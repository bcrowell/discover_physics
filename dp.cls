% notes on wrapfig:
%   wrapfig: for 2 figs in a row, both need to be in same wrapfig
%   wrapfig doesn't work in a theorem environment, so can't implement dqs and egs as thms
%	do wrapfig just before first line of a para
%	I thought it was messing up (positioning too far down) if I used it near a sectioning
%		command, but that doesn't seem to be the case. Sometimes works if you put it right
%		above the sectioning command. Other times when I thought it was a problem with the
%		sectioning command, changing the sectioning command to a styling command didn't help.
%
% example of how to do explanatory text in square brackets to the right of an equation:
%    \begin{multline*}
%	    v_t	=  \omega r   \qquad . \hfill
%	    \shoveright{\text{[tangential velocity of a point at a}}\\
%	     \text{distance $r$ from the axis of rotation]}
%    \end{multline*}
%
% Summary of my sectioning:
%   \mychapter{}, all words with initial caps in title
%   \mysection{}, all words with initial caps  in title; first section in a chapter needs \mysection[0]{}
%   \begin{envsubsection}{} or \begin{envsubsection}[x]{}, only first word in title capitalized
%   \subsubsection{}, only first in title word capitalized
%
% Notes about design:
%	Subsections and subsubsections are not numbered.
%	Only capitalize first word of example titles, subsections.
%	Subfigures are numbered 1, 2, etc, in 9-point Helv, captions labeled like "1" or "1. blah"
%	Figures are numbered within sections. (This could result in high letters,
%		but doing subsections leads to incongruous starting over from "a.")
%	All figures have to have captions, since otherwise "c/" looks bare.
%		Where L&M had a series of panels (a), (b), ..., SN has
%		a single letter, but a series of subfigures 1, 2, etc.
%		Refer to subfigs as a/1, etc. Subfigs without captions have (1), ... inside the figure.
%	Text within figures is 10-point Helvetica, except labels 1, 2, etc. All text within figures
%		is upright, even math variables.
%	Punctuation after displayed equations: \qquad in between.
%	Subscripts are italic, since this is what LaTeX makes it easy for me to do.
%	Equation numbers, when used, go on the left, to allow room for notes on the
%		right. Equation numbers are in square brackets,
%		numbered within sections.
%	Problem with equation numbers in examples: not indented, and not in sans.
%	page breaks:
%		mysection makes a pagebreak by default, but can give it an optional parameter
%			to make it less likely to happen.
%		subsection environment makes a pagebreak[3] by default, which usually doesn't result
%			in a pagebreak, but can use optional argument 4 to force it
%		Introducing page breaks always seems to make equations get spaced out a whole
%			bunch, which looks stupid. This seems to happen even if I sprinkle
%			\myeqnspacing all over the place. The solution is to precede the page
%			break with a \vfill.
%	Differentials and vectors are upright. Can do bold vectors with \boldmath outside of math mode,
%	or \mathbf or \boldsymbol in math mode.
%   In example title, first letter of first word is capitalized.
%	When an example has more than one part, number them (1), (2),... 
%
% Figures mostly in Adobe Illustrator 6 EPS. In some cases, I've saved them as
% Illustrator 1 EPS to save space; however, it isn't possible to do this with
% figures that have text in them, because, at least on my MacOS 9/X system,
% Illustrator gets confused about the fonts. (Also, named colors are lost
% in Illustrator 1 EPS.)
%
% I've activated pdflatex's margin kerning feature. For the fonts used in this
% book, I decided that the margins appeared straightest when I modified 
% protcode.tex to use half the amount of margin kerning that was supplied by
% default. (One expects this to be completely dependent on the font and size.)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dp}

\LoadClass[11pt]{book}
% Note that 11 pt does work with pdflatex, even though 11 pt is not one of the sizes
% of CM. I don't know whether it scales up 10 pt or scales down 12 pt, but anyway, it
% works.

\RequirePackage{alphalph,mytocloft,titlesec,titletoc,multicol,makeidx,wrapfig,fancyhdr,calc,amssymb,moreverb,ifthen,lmmath,framed}
\RequirePackage[pdftex]{color}%see pdftex mailing list, 2004 May 22-23
% Notes:
%   tocloft -- Using this has the effect, which I want, of suppressing the mandatory clearpage before the table of contents.
\renewcommand{\sfdefault}{phv}
     % ... helvetica for sans serif; this has to come before sansmath.sty
\RequirePackage[EULERGREEK]{sansmath}
     % ... sansmath.sty by Donald Arseneau, to be released ca. 3/2002.
     % The EULERGREEK option is necessary with Helvetica, because otherwise
     % there is no uppercase Greek. He actually doesn't recommend using sansmath.sty
     % with Helvetica, since some of the symbols match the letters poorly, but
     % I had hundreds of preexisting figures with Helvetica in them.
\RequirePackage[leqno]{amsmath}
% The following line is for margin kerning. There is more stuff
% relating to margin kerning after the begin{document}, and that's
% where to go if I want to turn it off.
\newboolean{wantmarginkerning}
\setboolean{wantmarginkerning}{true}
\newcommand{\inputprotcode}{\ifthenelse{\boolean{wantmarginkerning}}{\input protcode.tex}{}}

\definecolor{shadecolor}{gray}{.85} % for framed.sty

% For the following, could use \leftrightarrows and \rightrightarrows, but that's going to confuse them
% because O and I could be going in opposite directions and yet both be getting farther from the mirror.
% Used to use up and down arrows, but that confused them because they thought it related to inverted images.
\newcommand{\upup}{++}
\newcommand{\updown}{+-}

%-------------------- counters -------------------
\newcounter{dqctr}[subsection]
\newcounter{egctr}[chapter]
\newcounter{scctr}[chapter]
\newcounter{hwctr}[chapter]
\newcounter{figctr}[chapter] % for my roll-your-own captions
\newcounter{appendixctr}
\newcounter{labctr}[chapter]
\newcounter{labpartctr}[section]
\newcounter{prelabctr}[section]

\renewcommand{\thedqctr}{\Alph{dqctr}}
\renewcommand{\thefigctr}{\alphalph{\value{figctr}}}
\renewcommand{\thelabctr}{\alph{labctr}}
\renewcommand{\thelabpartctr}{\Alph{labpartctr}\quad}

%========================= sans serif math stuff =========================
% sansmath.sty takes care of it. The following is just to get back to normal
% math mode:
\newcommand{\lmserifmath}{\mathversion{normal}\everymath{}\everydisplay{}}

%========================= design =========================
\newcommand{\labelimportantintext}[1]{\textbf{#1}}
\newenvironment{important}[1][]%
	{\begin{shaded}\ifthenelse{\equal{#1}{}}{}{\textbf{#1}\\*}}%
	{\end{shaded}}
\newcommand{\lessimportant}[2][]{%
	\noindent\ifthenelse{\equal{#1}{}}{}{\textbf{#1}\\*}\noindent\myindented{5mm}{#2}%
}
\definecolor{secnumgray}{gray}{.55}
\newcommand{\showsecnum}[1]{\color{secnumgray}#1}
% titlesec stuff:
\titleformat{\chapter}[display]
    {\normalfont\huge\bfseries\sffamily}{Chapter \thechapter}{0mm}
    {\Huge}
\newcommand{\normalsectiontitleformat}{
  \titleformat{\section}
    {\normalfont\Large\bfseries\sffamily}{\showsecnum{\thesection}}{0.6em}{}
}
\newcommand{\labsectiontitleformat}{
  \titleformat{\section}
    {\normalfont\Huge\bfseries\sffamily}{\showsecnum{\thesection}}{0.6em}{}
}
\normalsectiontitleformat
\titleformat{\subsection}
  {\normalfont\normalsize\bfseries\sffamily}{}{0em}{}
%\titleformat{\subsubsection}
%  {\normalfont\normalsize\textsl}{\thesubsubsection}{1em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\slshape}{\thesubsubsection}{1em}{}

\titlespacing*{\chapter}{0mm}{4mm}{6mm}
\titlespacing*{\section}{0mm}{4mm}{0mm}
\titlespacing{\subsection}{0mm}{1mm}{-0.5mm}
\titlespacing{\subsubsection}{0mm}{1mm}{-0.5mm}

\newcommand{\formatlikesection}[1]{\vspace{2.5mm}\Large{\bfseries{\sffamily{#1}}}\normalsize\normalfont}
\newcommand{\formatlikesubsection}[1]{\bfseries{\sffamily{#1}}\normalsize\normalfont}
\newcommand{\formatlikesubsubsection}[1]{\textsl{#1}\normalsize\normalfont}

\newcommand{\startscanswers}[1]{\pagebreak[4]\noindent\formatlikesection{Answers to Self-Checks for Chapter \ref{#1}}\nopagebreak\par}
\newcommand{\dqheader}{\pagebreak[1]\noindent\formatlikesubsection{Discussion Questions}\nopagebreak\par}
\newenvironment{dq}{\refstepcounter{dqctr}\noindent\small\sffamily\textbf{\thedqctr}\myeqnspacing\protect\sansmath}{\lmserifmath\par\myeqnspacing}

%Summary appendix:
\newcommand{\summarych}[2]{\noindent\formatlikesection{Chapter \ref{#1}, #2, page \pageref{#1}}\label{summary#1}\\}
\newcommand{\sumem}[1]{\emph{#1}}

\newcommand{\hwanshdr}[1]{\noindent\textbf{Page \pageref{#1}, problem \ref{#1}:}\ }
\newcommand{\hwsolnhdr}[1]{\noindent\textbf{Page \pageref{#1}, problem \ref{#1}:}\ }
\newcommand{\scanshdr}[1]{\noindent\textbf{Page \pageref{sc:#1}, self-check \ref{sc:#1}:}\ \label{scans:#1}}

%-------------------- page layout dimensions -------------------
% standard stuff, see LaTeX companion, p. 85:
  \setlength{\hoffset}{0mm}
  \setlength{\textwidth}{113mm}
  \setlength{\marginparsep}{6mm}
  \setlength{\columnsep}{6mm}
  \setlength{\voffset}{-4mm}
  \setlength{\textheight}{230mm}
  \setlength{\topmargin}{-12mm}
  \setlength{\headheight}{4mm}
  \setlength{\headsep}{8mm}
  \setlength{\footskip}{15mm}
% my stuff:
  \setlength{\oddsidemargin}{7mm}
  \newlength{\marginfigwidth}
  \setlength{\marginfigwidth}{52mm}
  \newlength{\overhang}
  \setlength{\overhang}{\marginfigwidth}
  \addtolength{\overhang}{\columnsep}
  \setlength{\evensidemargin}{\overhang}
  \addtolength{\evensidemargin}{-11mm}
  \newlength{\marginfigoverhang}
  \setlength{\marginfigoverhang}{\overhang}
  \newlength{\mysteriousextracolsep}
  \setlength{\mysteriousextracolsep}{3mm}
  \addtolength{\marginfigoverhang}{\mysteriousextracolsep}
           %supposed to =columnsep+marginfigwidth, for wrapfig; extra few mm is empirical
  \newlength{\pagewidth}
  \setlength{\pagewidth}{\textwidth}
  \addtolength{\pagewidth}{\marginparsep}
  \addtolength{\pagewidth}{\marginfigwidth}
% to allow changing from one layout to another:
\newlength{\normaltextwidth}
\setlength{\normaltextwidth}{\textwidth}
\newlength{\normalesm}
\setlength{\normalesm}{\evensidemargin}
\newcommand{\normallayout}{
	\clearpage
	\setlength{\textwidth}{\normaltextwidth}
	\setlength{\evensidemargin}{\normalesm}
}
\newcommand{\nomarginlayout}{
	\normallayout
	\addtolength{\textwidth}{\marginparwidth}
	\addtolength{\textwidth}{\marginparsep}
	\addtolength{\evensidemargin}{-\marginparwidth}
	\addtolength{\evensidemargin}{-\marginparsep}
}
%-------------------- paragraph formatting -------------------
%Have to do the \parafmt /after/ the toc:
\newcommand{\normalparafmt}{
	\setlength{\parindent}{\normalparindent}
	\setlength{\parskip}{2mm}
}
\newcommand{\parafmt}{
	\newlength{\normalparindent}% ...has to be after TOC to avoid extra spacing in TOC
	\setlength{\normalparindent}{6mm}
	\normalparafmt
}
%-------------------- fancyhdr -------------------
\newcommand{\yesiwantarabic}{\renewcommand{\thepage}{\arabic{page}}}
\renewcommand{\headrulewidth}{0mm}
\renewcommand{\footrulewidth}{0mm}
%\setlength{\headrulewidth}{0mm}
\newcommand{\printthesection}{Section\ \thesection} % for titlesec, hw environment
% LaTeX companion, p. 96
% Force headings outward, so they're not confined to text column:
  \setlength{\headwidth}{\textwidth}
  \addtolength{\headwidth}{\marginfigoverhang}
\newlength{\myfooterspace}
\setlength{\myfooterspace}{5mm}
\newlength{\myfooterspacep}
\setlength{\myfooterspacep}{19mm}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]%
  {\markboth{\textsf{Chapter\ \thechapter\hspace{\myfooterspace}#1}}{}}
\renewcommand{\sectionmark}[1]%
  {\markright{\textsf{\printthesection\hspace{\myfooterspace}#1}}{}}
%\newcommand{\myheadertext}{\textsf{PRELIMINARY VERSION}}
\newcommand{\myheadertext}{}
\lhead[\myheadertext]{}
\chead[]{}
\rhead[]{\myheadertext}
\lfoot[\textbf{\textsf{\thepage}} \hspace{\myfooterspacep} \nouppercase{\textsf{\leftmark}}]{}
\cfoot[]{}
\rfoot[]{\nouppercase{\textsf{\rightmark}} \hspace{\myfooterspacep} \textbf{\textsf{\thepage}}}
\fancypagestyle{plain}{%
  \fancyfoot{} %
  %\fancyfoot[R]{\textbf{\textsf{\thepage}}}%
}
%-------------------- epigraph commands -------------------
\newcommand{\epigraphlong}[2]{
  \noindent{}#1\par
  \noindent{}\myindented{10mm}{\textit{#2}}
}

\newcommand{\epigraph}[2]{
  #1 \hspace*{\fill}\nolinebreak[1]\hspace*{\fill}\textit{#2}
}
%...based on an example on p. 443 of LaTeX Companion
%-------------------- eg, selfcheck environments -------------------
\newlength{\egindent}
\setlength{\egindent}{3mm}
\newlength{\saveleftskip}
\newcommand{\myindented}[2]{%
  \setlength{\saveleftskip}{\leftskip}%
  \addtolength{\leftskip}{#1}#2%
 \par  \setlength{\leftskip}{\saveleftskip} \par%
}
\definecolor{egrulegray}{gray}{.6}
\newlength{\egrulehspace}
\setlength{\egrulehspace}{.5mm}
\newcommand{\egrule}{\makebox[0mm][l]{\color{egrulegray}\rule{110.5mm}{0.5pt}}}
\newcommand{\egvrule}{\makebox[0mm][l]{\color{egrulegray}\rule{0.5pt}{2mm}}}
\newcommand{\egbothrules}{\makebox[0mm][l]{\hspace{-0.5mm}\raisebox{1.5mm}{\egvrule}\raisebox{3.5mm}{\egrule}}}
\newcommand{\egtit}[1]{\egbothrules\textit{\hspace{\egrulehspace}#1\hfill{}example \theegctr}}
\newenvironment{eg}[2][3]
	{%
	  	\refstepcounter{egctr}%
	  	\setlength{\saveleftskip}{\leftskip}%
  		\addtolength{\leftskip}{\egindent}%
  		\small\sffamily
		\pagebreak[#1]\noindent\egtit{#2}\\*\noindent\myeqnspacing\protect\sansmath%
	}
	{%
		 \lmserifmath\par\setlength{\leftskip}{\saveleftskip} \par\myeqnspacing%
	}
\renewcommand{\thescctr}{\Alph{scctr}}
\newcommand{\selfcheck}[2]{%
	\refstepcounter{scctr}%
	\noindent\hspace{-1mm}\egbothrules\hspace{\egrulehspace}%
	\textsf{%
		\myindented{\egindent}{\small{\textit{Self-check \thescctr}\\*\protect\sansmath{}#2 \scans{#1}\label{sc:#1}}%
	}}\lmserifmath}
\newcommand{\egquestion}{\noindent\ensuremath{\triangleright}\ }
\newcommand{\eganswer}{\noindent\ensuremath{\triangleright}\ }
\newenvironment{likeeg}
	{%
	  	\setlength{\saveleftskip}{\leftskip}%
  		\addtolength{\leftskip}{\egindent}%
  		\small\sffamily\noindent
	}
	{%
		 \par\setlength{\leftskip}{\saveleftskip} \par%
	}

%-------------------- figure preferences -------------------
% The following three numbers are to make TeX more likely to put figures on the
% same page rather than on a separate figures page. Can tinker with these, but
% make sure floatpagefraction<topfraction.
% Values recommended by the web page I found were 0.85, 0.1, 0.75
\renewcommand{\topfraction}{0.99}
\renewcommand{\textfraction}{0.01}
\renewcommand{\floatpagefraction}{0.98}
%-------------------- my figure commands -------------------
% For an example of how to do a figure containing LaTeX text, see fig:hmassratios
% in chapter 8.
%
% Force it to start figure numbering afresh with each chapter:
  \newcommand{\zapcounters}{\setcounter{figctr}{0}}
% The following is complicated, because I want to be able to have chapter opener pictures that appear before the
% chapter's title:
  \newcommand{\mychaptercmdsa}{%
           \renewcommand\cleardoublepage{}%
	   \clearpage
	   \ifodd\c@page
           \else
		  \hbox{}\newpage
           \fi
           \zapcounters
  }
  \newcommand{\mychaptercmdsb}{%
           \thispagestyle{fancy}\myeqnspacing%
  }
  \newcommand{\mychapter}[1]{\mychaptercmdsa\chapter{#1}\mychaptercmdsb}
  \newcommand{\mychapterwithopener}[3]{%
         \mychaptercmdsa%
         \noindent\widefignocaption{#1}\formatlikecaption{#2}%
         \par\chapter{#3}%
         \mychaptercmdsb%
  }
  \newcommand{\mychapterwithopenernocaption}[2]{%
         \mychaptercmdsa%
         \noindent\widefignocaption{#1}%
         \par\vfill\hspace{-9mm}\noindent\chapter{#2}%
         \mychaptercmdsb%
  }
  \newcommand{\mysection}[2][4]{\pagebreak[#1]%
	\section{#2}\myeqnspacing}
  \newenvironment{envsubsection}[2][3]%
    {\pagebreak[#1]\subsection{#2}}%
    {}
% Letters for figure number, and no "Figure .." in caption:
  \newcommand{\hwcaptions}{\def\figurelabel{}}
  \newcommand{\normalcaptions}{\def\figurelabel{\thefigctr\hspace{1mm}{\scriptsize{/}}\hspace{1mm}}}
  \normalcaptions
%
\newcommand{\marg}[1]{\margup{0mm}{#1}}
\newcommand{\margup}[2]{
	\begin{wrapfigure}{o}[\marginfigoverhang]{0mm}%
		\begin{minipage}{\marginfigwidth}
			\vspace*{#1}
			#2
		\end{minipage}
	\end{wrapfigure}
}
\newcommand{\formatlikecaption}[1]{%
	\small{\protect\sansmath\sf{#1}\lmserifmath} %
}
\newcommand{\docaptionnorefstep}[2][l]{%
	\break%
        \ifthenelse{\equal{#1}{r}}{\hspace*{\fill}}{}
        \formatlikecaption{\figurelabel#2}%
        \hfill%
}
\newcommand{\docaption}[1]{%
        \refstepcounter{figctr}%
        \docaptionnorefstep{#1}%
}
% In the following, the optional first argument is appended to the end of
% the label. This is necessary sometimes if I'm including the same figure
% more than once and want to have separate labels.
\newcommand{\fullpagewidthfigleft}[2]{ %
	\begin{figure}[h]
	\hspace{-\marginfigoverhang}\includegraphics[width=\pagewidth]{\chapdir/figs/#1}\\
	\docaption{#2} %
	  \label{fig:#1} %
	\end{figure}
}
% The following doesn't work, because the caption isn't as wide as the figure:
\newcommand{\fullpagewidthfigright}[2]{ %
	\begin{figure}[h]
	\includegraphics[width=\pagewidth]{\chapdir/figs/#1}\\
	\docaption{#2} %
	  \label{fig:#1} %
	\end{figure}
}
\newcommand{\fullpagewidthfigleftnocaption}[1]{ %
	\begin{figure}[h]
	\hspace{-\marginfigoverhang}\includegraphics[width=\pagewidth]{\chapdir/figs/#1}\\
	  \label{fig:#1} %
	\end{figure}
}
\newcommand{\fullpagewidthfigleftanonymous}[1]{ %
	\begin{figure}[h]
	\hspace{-\marginfigoverhang}\includegraphics[width=\pagewidth]{\chapdir/figs/#1}
	\end{figure}
}
\newcommand{\fullpagewidthfigrightnocaption}[1]{ %
	\begin{figure}[h]
	\includegraphics[width=\pagewidth]{\chapdir/figs/#1}\\
	  \label{fig:#1} %
	\end{figure}
}
\newcommand{\fig}[3][]{ %
	\includegraphics[width=\marginfigwidth]{\chapdir/figs/#2} %
	\docaption{#3} %
	\label{fig:#2#1} %
}
\newcommand{\formatfigref}[1]{\textit{#1}}
\newcommand{\figref}[1]{\formatfigref{\ref{fig:#1}}}
\newcommand{\subfigref}[2]{\textit{\ref{fig:#1}}/#2}
\newcommand{\fignocaption}[1]{%
	\includegraphics[width=\marginfigwidth]{\chapdir/figs/#1} %
	\label{fig:#1} %
}
\newcommand{\fignoresize}[2]{ %
	\includegraphics{\chapdir/figs/#1} %
	\docaption{#2} %
	\label{fig:#1} %
}
\newcommand{\widefig}[3][h]{ %
	\spaceabovewidefig
	\begin{figure}[#1]
	\includegraphics[width=\textwidth]{\chapdir/figs/#2} %
	\docaption{#3} %
	\label{fig:#2} %
	\end{figure}
}
\newcommand{\widefignocaption}[1]{ %
	\spaceabovewidefig
	\includegraphics[width=\textwidth]{\chapdir/figs/#1} %
	\label{fig:#1} %
}
\newcommand{\inlinefignocaption}[1]{ %
	\spaceabovewidefig
	\includegraphics[width=\textwidth]{\chapdir/figs/#1}\label{fig:#1}
}
\newcommand{\inlinefignocaptionnoresize}[1]{ %
	\spaceabovewidefig
	\includegraphics{\chapdir/figs/#1}\label{fig:#1}
}
\newcommand{\widefigsuffixed}[4]{ %
	\spaceabovewidefig
	\begin{figure}[#1]
	\includegraphics[width=\textwidth]{\chapdir/figs/#3} %
	\docaption{#4} %
	\label{fig:#3#2} %
	\end{figure}
}
\newsavebox{\sidecaptionbox}
\newsavebox{\includegraphicsbox}
\newlength{\xmarginscoot}
\newlength{\ymarginscoot}
\newlength{\kludge}
\newlength{\oddsidemarginscoot}
\setlength{\oddsidemarginscoot}{\textwidth}
\addtolength{\oddsidemarginscoot}{\marginparsep}
\addtolength{\oddsidemarginscoot}{\mysteriousextracolsep}
\newlength{\evensidemarginscoot}
\setlength{\evensidemarginscoot}{\marginfigwidth}
\addtolength{\evensidemarginscoot}{\marginparsep}
\addtolength{\evensidemarginscoot}{\mysteriousextracolsep}
\newlength{\adjustevensidemargin}
\setlength{\adjustevensidemargin}{-3.5mm}
\addtolength{\evensidemarginscoot}{\adjustevensidemargin}
 % ...This is necessary in order to make it line up with margin figs, which are actually too close
 % to the text for some mysterious reason.
\newcommand{\widefigsidecaption}[3][t]{%
                  % #1 = t to align top of caption with top of figure, c to align centers, b for bottoms
                  % #2 = name of graphic
                  % #3 = caption
	\spaceabovewidefig
	\begin{lrbox}{\includegraphicsbox}\begin{minipage}{\textwidth}\includegraphics[width=\textwidth]{\chapdir/figs/#2}\end{minipage}\end{lrbox}%
        \refstepcounter{figctr}
	\begin{lrbox}{\sidecaptionbox}\begin{minipage}{\marginfigwidth}\docaptionnorefstep{#3}\end{minipage}\end{lrbox}%
	\ifthenelse{\isodd{\pageref{fig:#2}}}{%
          \setlength{\xmarginscoot}{\oddsidemarginscoot}
        }%
        {% even, left-hand page
          \setlength{\xmarginscoot}{-\evensidemarginscoot}
	  \settowidth{\kludge}{\formatlikecaption{#3}}
          \ifthenelse{\lengthtest{\kludge < \marginfigwidth}}{
	    \begin{lrbox}{\sidecaptionbox}\begin{minipage}{\marginfigwidth}\docaptionnorefstep[r]{#3}\end{minipage}\end{lrbox}%
          }{}
        }
        \ifthenelse{\equal{#1}{t}}{
          \settoheight{\ymarginscoot}{\usebox{\includegraphicsbox}}
          \settodepth{\kludge}{\usebox{\includegraphicsbox}}
	  \addtolength{\ymarginscoot}{\kludge}
          \settoheight{\kludge}{\usebox{\sidecaptionbox}}
	  \addtolength{\ymarginscoot}{-\kludge}
        }{}
        \ifthenelse{\equal{#1}{b}}{
          \settodepth{\ymarginscoot}{\usebox{\sidecaptionbox}}
        }{}
        \ifthenelse{\equal{#1}{c}}{
          \settodepth{\ymarginscoot}{\usebox{\includegraphicsbox}}
        }{}
        \par
	\noindent\usebox{\includegraphicsbox}
        \raisebox{\ymarginscoot}[0mm][0mm]{\makebox[0mm][l]{\hspace{\xmarginscoot}\usebox{\sidecaptionbox}}}
        \par
	\label{fig:#2} %
}
\newcommand{\anonymousinlinefig}[1]{\includegraphics{\chapdir/figs/#1}}
\newlength{\toccolumnwidth}
\setlength{\toccolumnwidth}{77mm}%kludge -- shouldn't hardcode this
\newcommand{\figureintoc}[1]{\par\includegraphics[width=\toccolumnwidth]{ch00/figs/#1}\par}
\newcommand{\figureintocnoresize}[1]{\par\includegraphics{ch00/figs/#1}\par}%only needed if you want the figure to hang over the edge
% ...To use these, do this:   \addtocontents{toc}{\protect\figureintoc{myfig}}
\newcommand{\spacebetweenfigs}{
	\vspace{6mm}
}
\newcommand{\spaceabovewidefig}{\vspace{1mm}}
%-------------------- homework remark -------------------
\newcommand{\hwremark}[1]{\par\noindent\footnotesize{\textit{Remark:\/} #1}}
%-------------------- photo credit command -------------------
\newcommand{\photocredit}[1]{\footnotesize{(\textit{#1})}}
%-------------------- theorem header -------------------
\newcommand{\mythmhdr}[1]{\noindent\textbf{#1:}}

%-------------------- equation numbering -------------------
\numberwithin{equation}{section}
% Equation numbers have square brackets:
%   Original code from amsmath.sty:
%		\def\tagform@#1{\maketag@@@{(\ignorespaces#1\unskip\@@italiccorr)}}
%   Change it as follows:
		\renewcommand{\tagform@}[1]{\maketag@@@{[\ignorespaces#1\unskip\@@italiccorr]}}
%	Use \eqref to refer to an equation.
%\renewcommand{\theequation}{\ensuremath{\fnsymbol{equation}}} % used to use symbols...
\renewcommand{\theequation}{\ensuremath{\arabic{equation}}} % ... now using numbers
%-------------------- labs -----------------------------
% Some magic courtesy of Robin Fairbairns:
\newcommand{\forceleftpage}{%
          \clearpage
	  \if@twoside
		\ifodd\c@page
		  \hbox{}\newpage
		  \if@twocolumn \hbox{}\newpage \fi
		\fi
	  \fi
}
\newcommand{\normallabfont}{\small\normalfont}
\newcommand{\labformatting}{\setlength{\parindent}{0mm}\setlength{\parskip}{1.5mm}\normallabfont}
\newcommand{\normalformatting}{\normalparafmt\normalsize\normalfont}
\newcommand{\normalsloppyfussy}{\fussy}
\newcommand{\labsectionmark}{} % see below
% \begin{lab}{Title}, or \begin{lab}[0]{Title} if the lab is one page, and doesn't need to be forced to start on a left-hand page.
\newenvironment{lab}[2][1]{
    \refstepcounter{labctr}              % 
    \setcounter{secnumdepth}{0}          % Don't number this section.
    \setcounter{labpartctr}{0}           % This shouldn't be necessary, but I guess it's another problem with \mysection inside twocolumn[]
    \renewcommand{\printthesection}{}    % Footers should read ``Lab 6a,'' not ``Section X.Y Lab 6a''
    \setcounter{figure}{0}               %
    \nomarginlayout\labformatting\sloppy
    \ifthenelse{\equal{#1}{1}}{\forceleftpage}{}
    \labsectiontitleformat
    \renewcommand{\labsectionmark}{Lab \thechapter\thelabctr: #2}
    \sectionmark{\labsectionmark}             % \mysection should take care of this, but doesn't seem to when inside twocolumn[...]
    \twocolumn[\mysection{\labsectionmark}]   % \mysection Has the side-effect of generating a page break.
    \setcounter{secnumdepth}{2}               % Start numbering sections again.
                                              % The \setcounter{secnumdepth} stuff is the way the author of titlesec suggests doing
                                              % this. Using section* messes up footers & toc. 
}%
{%
    \vfill\normalsloppyfussy\normallayout\normalformatting\normalsectiontitleformat\onecolumn
}
\newcommand{\formatlikelabsection}[1]{\Large{\bfseries{\sffamily{#1}}}\normallabfont}
\newcommand{\formatlikelabsubsection}[1]{\normalsize{\bfseries{\sffamily{#1}}}\normallabfont}
\newcommand{\formatlikelabsubsubsection}[1]{\textsl{#1}\normallabfont}
\newcommand{\keepheadwithpara}[1]{\vspace{#1}\par\nopagebreak}
\newcommand{\labsection}[1]{\vspace{1mm}\par\noindent\formatlikelabsection{#1}\keepheadwithpara{0mm}} % initial caps
\newcommand{\labsubsection}[1]{\vspace{1mm}\par\noindent\formatlikelabsubsection{#1}\keepheadwithpara{0mm}} % only first word capitalized
\newcommand{\labsubsubsection}[1]{\vspace{1mm}\par\noindent\formatlikelabsubsubsection{#1}\keepheadwithpara{0mm}} % only first word capitalized
\newcommand{\labintroduction}{\labsection{Introduction}}
\newcommand{\labobservations}{\labsection{Observations}}
\newcommand{\labselfcheck}{\labsection{Self-Check}}
\newcommand{\labwriteup}{\labsection{Writeup}}
\newcommand{\labpart}[1]{\refstepcounter{labpartctr}\labsubsection{\thelabpartctr #1}}
\newcommand{\apparatus}{\labsection{Apparatus}}
\newcommand{\prelab}{\labsection{Prelab}}
\newcommand{\apparatusdots}{\dotfill}
\newcommand{\equip}[1]{#1} 
\newcommand{\equipn}[2]{#1 \apparatusdots #2}
\newcommand{\goal}[1]{\labsection{Goal}#1}
\newenvironment{goals}{\labsection{Goals}\begin{itemize}}{\end{itemize}}
\newcommand{\longgoal}[1]{\labsection{Goal}}
\newcommand{\prelabquestion}{\refstepcounter{prelabctr}\noindent\textbf{P\theprelabctr}\quad }
% Lab sections normally use floating figures without captions, no resizing.
\newcommand{\captionforlabfig}[1]{\vspace{2mm}\parbox{\toccolumnwidth}{\formatlikecaption{#1}}}
\newcommand{\labfig}[2][h]{ %
	\begin{figure}[#1]%
	\begin{center}\includegraphics{\chapdir/figs/#2}\end{center}
	\end{figure}%
}
\newcommand{\labfigcaption}[3][h]{ %
	\begin{figure}[#1]%
	\begin{center}
          \includegraphics{\chapdir/figs/#2}\\*
          \captionforlabfig{#3}
        \end{center}
	\end{figure}%
}
\newcommand{\labwidefig}[2][h]{ %
	\begin{figure*}[#1]%
	  \includegraphics{\chapdir/figs/#2} %
	\end{figure*}%
}
% The following doesn't really work very well, because the figure goes on its
% own page, and the caption is as narrow as a single column:
\newcommand{\labwidefigcaption}[3][h]{ %
	\begin{figure*}[#1]%
	  \includegraphics{\chapdir/figs/#2} %
          \captionforlabfig{#3}
	\end{figure*}%
}
% The following three numbers are to make TeX more likely to put figures on the
% same page rather than on a separate figures page. Can tinker with these, but
% make sure floatpagefraction<topfraction.
% Values recommended by the web page I found were 0.85, 0.1, 0.75
\renewcommand{\topfraction}{0.99}
\renewcommand{\textfraction}{0.01}
\renewcommand{\floatpagefraction}{0.98}
%-------------------- hw section & hw problem environments-------------------
\newcommand{\hwdifficulty}{0}
% ... This needs to be a global variable because I only display the symbol in  \end{hw},
%     which doesn't have access to #1.
\newsavebox{\hwtrailingstuff}
% There is also a boolean register, hwhavetrailing, defined under AtBeginDocument.
%
% The homework problem section is supposed to be like any other section, but not numbered.
% addtocontents: see Lamport, p. 176
\newenvironment{hwsection}{
    \setcounter{secnumdepth}{0}          % Don't number this section.
    \renewcommand{\printthesection}{}    % Footers should read ``Problems,'' not ``Section X.Y Problems''
    \hwcaptions                          % figures in hw section don't have a, b, c, labels
    \setcounter{figure}{0}               %
    \mysection{Problems}                 % Has the side-effect of generating a page break.
    \setcounter{secnumdepth}{2}          % Start numbering sections again.
                                         % The \setcounter{secnumdepth} stuff is the way the author of titlesec suggests doing
                                         % this. Using section* messes up footers & toc. 
}%
{\vfill}
%
\newcommand{\hwnote}[1]{\noindent\emph{#1}}
\newenvironment{hw}[2][1]
	{\refstepcounter{hwctr}\label{hw:#2}\noindent\textbf{\thehwctr}%
	\renewcommand{\hwdifficulty}{#1}%
        \ifthenelse{\equal{#1}{2}}{*}{}
	\hwcleartrailingstuff
	\quad}
	{%
             \hwaddtrailingstuff{%
                                %\displayhwdifficulty{\hwdifficulty}
                            }%
             \hwflushtrailingstuff\par%
        }
%
\newcommand{\hwendpart}[1][3]{\hwflushtrailingstuff[#1]\\}
%	The optional argument ends up being passed to \nolinebreak. It defaults to 3, but
%	you can make it 2 or 4 if it seems to be making the wrong decision.
%   If there is only one part to the problem, or if you're fiddling with the very last
%   part of a multipart problem, I think you can add a gratuitous \hwendpart, but
%   except in this situation, don't do \hwendpart after the last part, because sometimes
%   it causes extra blank lines to appear.
%
\newcommand{\hwhint}[1]{\hwaddtrailingstuff{\hwtriangle\ Hint, p. \pageref{#1}}}
\newcommand{\hwans}[1]{\hwaddtrailingstuff{\hwtriangle\ Answer, p. \pageref{#1}}}
\newcommand{\hwsoln}[1]{\hwaddtrailingstuff{\hwtriangle\ Solution, p. \pageref{#1}}}
\newcommand{\answercheck}{\hwaddtrailingstuff{\hwcheckmark}}
\newcommand{\displayhwdifficulty}[1]{\includegraphics{resources/difficulty#1}}
%
\newcommand{\hwtriangle}{$\triangleright$}
\newcommand{\hwcheckmark}{\scriptsize\raisebox{1mm}{$\surd$}\normalsize}
%
\newcommand{\hwflushtrailingstuff}[1][3]{\ifthenelse{\boolean{hwhavetrailing}}{\hwfill{#1}\usebox{\hwtrailingstuff}\hwcleartrailingstuff}{}}
%
\newcommand{\hwcleartrailingstuff}{\sbox{\hwtrailingstuff}{}\setboolean{hwhavetrailing}{false}}
%
\newcommand{\hwaddtrailingstuff}[1]{\sbox{\hwtrailingstuff}{\usebox{\hwtrailingstuff}\quad{}#1}%
                                             \setboolean{hwhavetrailing}{true}}
%
\newcommand{\hwfill}[1]{\hspace*{\fill}\nolinebreak[#1]\nopagebreak[1]\hspace*{\fill}}
% ... cf LaTeX Companion, p. 443
%
%
\newcommand{\scans}[1]{$\triangleright$\ Answer, p. \pageref{scans:#1}}
\newcommand{\noetherimplies}{\ensuremath{\Rightarrow}}
\newenvironment{noethertable}{%
  \noindent\hspace{5mm}\begin{tabular}{|p{40mm}cp{40mm}|}
  \hline
	\textbf{symmetry} & & \textbf{conserved quantity} \\
}%
{
  \hline
\end{tabular}
}
%=========================
\newcommand{\mynormaltype}{\normalsize\normalfont\myeqnspacing}
\newcommand{\myeqnspacing}{
	\setlength{\abovedisplayskip}{4mm plus 1mm minus 3mm}
	\setlength{\belowdisplayskip}{4mm plus 1mm minus 3mm}
	\setlength{\abovedisplayshortskip}{0mm plus 1mm}
	\setlength{\belowdisplayshortskip}{2mm plus 1mm minus 1mm}
}
%==============================toc==================================
%For the following, see the documentation for tocloft.sty:
\renewcommand{\contentsname}{}
\setlength{\cftbeforetoctitleskip}{0mm}
\setlength{\cftaftertoctitleskip}{0mm}
%titletoc stuff:
\newcommand{\formatchtoc}[3]{%
  \titlecontents{chapter}[0mm]{\addvspace{#3}\sffamily}%
	{\contentsmargin{0mm}#1\thecontentslabel\enspace#1}%
	{\contentsmargin{0mm}#1}{#2}[]%
}
\contentsmargin{6mm}
\titlecontents{part}[0mm]{\addvspace{5mm}\sffamily\bfseries}
	{\contentsmargin{0mm}\bfseries\Large{}\thecontentslabel\enspace\Large}
	{\contentsmargin{0mm}\Large}{}[\addvspace{2mm}]
\titlecontents{section}[0mm]{\sffamily}
	{\contentsmargin{0mm}\thecontentslabel\enspace}
	{}{\titlerule*[4mm]{.}\contentspage}
% In the following, titlecontents* is titletoc's way of saying I want subsections listed in a single paragraph.
\titlecontents*{subsection}[1.5em]{\small}{}%
		{}{, \thecontentspage}[.---][.]
\titlecontents{subsubsection}[]{}{}{}{}[]
% Brief contents:
\titlecontents{briefchapter}[0mm]{\Large\sffamily{}}
        {}{}
        {}
%========================= graphicx package=========================
\newif\ifpdf
\ifx\pdfoutput\undefined
\pdffalse % we are not running PDFLaTeX
\else
\pdfoutput=1 % we are running PDFLaTeX
\pdftrue
\fi

\ifpdf
\usepackage[pdftex]{graphicx}
\else
\usepackage{graphicx}
\fi
%========================= AtBeginDocument stuff=========================
\AtBeginDocument{
  \newboolean{hwhavetrailing}
  %------------------------------- pdf stuff
	\ifpdf
	\DeclareGraphicsExtensions{.pdf,.jpg}
	\else
	\DeclareGraphicsExtensions{.eps,.jpg}
	\fi
  \newcommand{\chapdir}{glub}
  %------------------------------- equation spacing 
  \myeqnspacing
  	% This gets reset any time I do normalsize, so have to do it after preamble,
  	% and have to use \mynormaltype rather than \normalsize
}
