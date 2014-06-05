#!/usr/bin/perl

print "      ";
for ($v= -1.0; $v<=1; $v+=0.2) {
  print_one(num_format($v));
  print " ";
}
print "\n";

for ($u= -1.0; $u<=1; $u+=0.2) {
  print_one(num_format($u));
  print " ";
  for ($v= -1.0; $v<=1; $v+=0.2) {
    #$a = 1.0+$u*$v; # relativistic
    $a = 1.0; # nonrelativistic
    if ($a != 0) {
      $a = 1.0/$a;
      $b = $u+$v;
      $c = $a*$b;
      print_one(num_format($c));
    }
    else {
	print_one("     ");
    }
    print " ";
    #print " & ";
  }
  #print "\\\\\n";
  print "\n";
}

sub print_one {
    my $x = shift;
    print $x;
    #print "\\scriptsize{".$x."}";
}

sub num_format {
    my $x = shift;
    return (sprintf "%5.2f",$x);
}
