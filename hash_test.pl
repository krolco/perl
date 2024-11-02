#!perl -w

use Digest::MD5 qw(md5_hex);


my %fileCounts;
my %fileNames;

foreach (@ARGV) {
	# Slurp file in here
	my $slurpedData;
	my $hash = md5_hex($slurpedData);
	
	$fileCounts{$hash}++;
	$fileNames{$hash} ||= $_;
}

# Now dump the results...
	
