#!perl
chomp(@words = <STDIN>);
foreach (@words) {
	$names{$_} += 1;
}
# Now print results...
#
foreach $word (sort keys %names) {
	print "$word : $names{$word}\n";
}
