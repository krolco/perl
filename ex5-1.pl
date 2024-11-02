#!perl
#
%names = (
	fred => flintstone,
	barney => rubble,
	wilma => flintstone
);

print "Enter a given name >";
$name = <STDIN>;
chomp($name);
if( exists $names{$name}) {
	print "$name\'s given name is $names{$name}";
}

