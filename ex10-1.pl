#!perl


print "Guess a number from 1 to 100!\n";

my $secret = int( 1 + rand 100);

while (<>) {
	chomp($_);

	if (/quit|exit|^\s*$/) {
		print "Sorry you gave up. The number was $secret.\n";
		last;
	}
	
	if ($_ > $secret) {
		print "Too High!\n";
		next;
	}
	if ($_ < $secret) {
		print "Too Low!\n";
		next;
	}

	if ($_ == $secret) {
		print "Congrats! You guessed correctly with $secret\n";
		last;
	}

}

