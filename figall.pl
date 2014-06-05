#!/usr/bin/perl

my @a =  glob "*.eps.gz";


foreach my $a(@a) {
    $a =~ m/^(.*)\.eps\.gz$/;
    my $pdf = "$1.pdf";
    if (! -e $pdf) {
      print "fig $a\n";
      system("fig $a");
    }
}
