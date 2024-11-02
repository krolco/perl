#!perl

#print the debugging ruler

chomp(@lines = <>);

# first line is the column width
$width = shift @lines;

print "The value of \$width is $width.\n";

#print the ruler line...
print ("1234567890" x (($width / 10) + 1));
print "\n";

foreach (@lines) {
	printf "%${width}s\n", $_;
}


