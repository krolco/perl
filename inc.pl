#!c:/perl/bin/perl.exe -wT
use strict;
use CGI;
use File::Find;
use File::CounterFile;

$File::CounterFile::DEFAULT_DIR = "c:\\temp";

my $c = new File::CounterFile "COUNTER", "bj00000";
my $id = $c->inc;
print "Current Id is $id";