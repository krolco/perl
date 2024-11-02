#!perl

#print the debugging ruler

chomp(@lines = <>);

print ("1234567890" x 5);
print "\n";

foreach (@lines) {
	printf "%20s\n", $_;
}


