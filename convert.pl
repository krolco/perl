#!perl

binmode (STDIN);
binmode (STDOUT);

@lines = <STDIN>;
foreach (@lines) {
	s/[Gg]\x00[Uu]\x00[Ll]\x00[Dd]\x00[Uu]\x00[Nn]/t\x00h\x00r\x00a\x00l\x00l\x00/g;
	print;
}

