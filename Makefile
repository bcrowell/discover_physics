include whichbook.make

DIST_DIR = $(BOOK)
DIST_ARCHIVE = $(BOOK).tar.gz
MODE = nonstopmode
TERMINAL_OUTPUT = err
MYSELF = Makefile

MAKEINDEX = makeindex $(BOOK).idx

DO_PDFLATEX_RAW = pdflatex -interaction=$(MODE) $(BOOK) >$(TERMINAL_OUTPUT)
SHOW_ERRORS = \
        print "========error========\n"; \
        open(F,"$(TERMINAL_OUTPUT)"); \
        while ($$line = <F>) { \
          if ($$line=~m/^\! / || $$line=~m/^l.\d+ /) { \
            print $$line \
          } \
        } \
        close F; \
        exit(1)
DO_PDFLATEX = echo "$(DO_PDFLATEX_RAW)" ; perl -e 'if (system("$(DO_PDFLATEX_RAW)")) {$(SHOW_ERRORS)}'

# Since book1 comes first, it's the default target --- you can just do ``make'' to make it.

book1:
	@$(DO_PDFLATEX)
	@rm -f $(TERMINAL_OUTPUT) # If pdflatex has a nonzero exit code, we don't get here, so the output file is available for inspection.

index:
	$(MAKEINDEX)

book:
	make clean
	@$(DO_PDFLATEX)
	@cksum $(BOOK).pdf
	@$(DO_PDFLATEX)
	@cksum $(BOOK).pdf
	$(MAKEINDEX)
	@$(DO_PDFLATEX)
	@cksum $(BOOK).pdf
	@rm -f $(TERMINAL_OUTPUT) # If pdflatex has a nonzero exit code, we don't get here, so the output file is available for inspection.

prepress:
	pdftk $(BOOK).pdf cat 3-end output temp.pdf
	# The following makes Lulu not complain about missing fonts. Make sure the version of gs is recent enough so that it won't mess up
	# ligatures in Helvetica. As of May 2006, the AFPL version of gs is the only one with the bug fix; the GPL'd version still has the bug.
	# note: changed to -dPDFSETTINGS=/printer instead of /prepress on 2006 jun 18, but haven't tested that yet
	gs-afpl -q  -dCompatibilityLevel=1.4 -dSubsetFonts=false -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$(BOOK)_lulu.pdf temp.pdf -c '.setpdfwrite'
	@rm -f temp.pdf

test:
	perl -e 'if (system("pdflatex -interaction=$(MODE) $(BOOK) >$(TERMINAL_OUTPUT)")) {print "error\n"} else {print "no error\n"}'

clean:
	rm -f $(DIST_ARCHIVE)
	# Sometimes we get into a state where LaTeX is unhappy, and erasing these cures it:
	rm -f *aux *idx *ilg *ind *log *toc
	rm -f ch*/*aux
	# Shouldn't exist in subdirectories:
	rm -f */*.log
	# Emacs backup files:
	rm -f *~
	rm -f */*~
	# Misc:
	rm -Rf ch*/figs/.xvpics
	rm -f a.a
	rm -f */a.a
	rm -f */*/a.a
	rm -f junk
	rm -f err
	# ... done.

very_clean: clean
	rm -f dp.pdf

dist:
	# Making public tarball...
	#
	make clean
	rm -f $(DIST_ARCHIVE)
	rm -Rf $(DIST_DIR)
	mkdir $(DIST_DIR)
	#
	cp README $(DIST_DIR)
	cp $(MYSELF) $(DIST_DIR)
	cp whichbook.make $(DIST_DIR)
	cp $(BOOK).tex $(DIST_DIR)
	cp -H dp.cls $(DIST_DIR)
	cp *.sty $(DIST_DIR)
	cp protcode.tex $(DIST_DIR)
	cp -Rf ch* $(DIST_DIR)/.
	rm -f $(DIST_DIR)/ch*/figs/*.png # Distribute the JPGs, which are smaller.
	rm -f $(DIST_DIR)/ch*/figs/*.pdf # Distribute the EPSs, which are editable with free software.
	perl -e 'if (-e "resources") {system "cp -Rf resources/* $(DIST_DIR)/."}' # only exists for Simple Nature
	#
	tar -zcvf $(DIST_ARCHIVE) $(DIST_DIR)
	#
	rm -Rf $(DIST_DIR)
	#
	ls -l $(DIST_ARCHIVE)
	#
	# ...done.

post:
	cp dp.pdf /home/bcrowell/Lightandmatter/dp
	cp dp.tar.gz /home/bcrowell/Lightandmatter/dp
