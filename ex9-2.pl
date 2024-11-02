#!perl

my $filename = shift @ARGV;
my %list;

open IN, "<$filename";

chomp(@lines = <IN>);
close (IN);

foreach (@lines) {
	if (/^=item\s+([a-z_]\w*)/i) {
		$list{$1} += 1;
	}
}

foreach (keys %list) {
	if ($list{$_} > 2) {
		print "$_ : $list{$_}\n";
	}
}
		