#!perl

$pi = 3.141592654;
$radius = <STDIN>;

if ($radius < 0) {
	print 0;
} else {
	$circum = 2 * $radius * $pi;
	print $circum;
}



