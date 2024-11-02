@names = qw/fred betty barney dino wilma pebbles bamm-bamm/;
chomp(@theList = <STDIN>);
foreach (@theList) {
	print "$names[$_]\n";
};

