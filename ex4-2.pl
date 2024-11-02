#!perl
sub total {
	my ( $total_so_far ) = shift @_;
	foreach (@_) {
		$total_so_far += $_;
	}
	$total_so_far;
}

my @fred = qw{ 1 3 5 7 9};
my $fred_total = &total(@fred);
print "The total of \@fred is $fred_total.\n";
#print "Enter some numbers on separate lines: ";
#my $user_total = &total(<STDIN>);
#print "The total of those numbers is $user_total.\n";
my @big_list;
foreach (1..1000) {
	push @big_list, $_;
}
my $big_total = &total(@big_list);
#print "The big list is @big_list\n";
print "The total of the big list is $big_total.\n";

