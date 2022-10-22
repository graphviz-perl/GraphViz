#/usr/bin/env perl

use strict;
use warnings;

# I tried 'require'-ing modules but that did not work.

use GraphViz; # For the version #.

use Test::More;

use Carp;
use Config;
use File::Which;
use Getopt::Long;
use IO::Dir;
use IO::File;
use IPC::Run;
use lib;
use LWP::Simple;
use Parse::RecDescent;
use Pod::Usage;
use strict;
use Time::HiRes;
use vars;
use warnings;
use XML::Twig;
use XML::XPath;

# ----------------------

pass('All external modules loaded');

my(@modules) = qw
/
	Carp
	Config
	File::Which
	Getopt::Long
	IO::Dir
	IO::File
	IPC::Run
	lib
	LWP::Simple
	Parse::RecDescent
	Pod::Usage
	strict
	Time::HiRes
	vars
	warnings
	XML::Twig
	XML::XPath
/;

diag "Testing GraphViz V $GraphViz::VERSION";

for my $module (@modules)
{
	no strict 'refs';

	my($ver) = ${$module . '::VERSION'} || 'N/A';

	diag "Using $module V $ver";
}

done_testing;
