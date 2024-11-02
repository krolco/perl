#!perl

binmode (STDIN);
binmode (STDOUT);

@lines = <STDIN>;
foreach (@lines) {
	s/[Oo]\x00[Gg]\x00[Rr]\x00[Ee]\x00/b\x00l\x00a\x00t\x00/g;
	print;
}

