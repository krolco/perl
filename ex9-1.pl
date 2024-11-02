#!perl

my $what = 'fred|barney';

chomp(@lines = <STDIN>);

foreach (@lines) {
	if ( /($what){3}/ ) {
		print "Line: $_\nMatched $&\n";
	}
}


