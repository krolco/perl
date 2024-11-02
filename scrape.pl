#!perl -w

use LWP::UserAgent;
use HTML::LinkExtor;
use URI::URL;

$url = "showthread.php?t=43776";
$ua = LWP::UserAgent->new;

# Set up a callback that collect image links
my @imgs = ();
sub callback {
    my($tag, %attr) = @_;
    return if $tag ne 'img';  # we only look closer at <img ...>
push(@imgs, values %attr);
}

# Make the parser.  Unfortunately, we don't know the base yet
# (it might be diffent from $url)
$p = HTML::LinkExtor->new(\&callback);

# Request document and parse it as it arrives
$res = $ua->request(HTTP::Request->new(GET => $url),
                  sub {$p->parse($_[0])});

# Expand all image URLs to absolute ones
my $base = $res->base;
@imgs = map { $_ = url($_, $base)->abs; } @imgs;

# Print them out
#print join("\n", @imgs), "\n";

print <<HEAD;
<html><head><title>Google</title></head>
HEAD
foreach (@imgs) {
    print "<img src=\"$_\" /><p>\n";   
}
print "</html>";

