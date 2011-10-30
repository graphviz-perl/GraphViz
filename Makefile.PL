use warnings;

use Config;

use ExtUtils::MakeMaker;

eval "require File::Which";

if ($@)
{
	die "Error: GraphViz requires File::Which to run Build.PL and Makefile.PL. \n";
}

if (! File::Which::which('dot') )
{
	die "Error: Did not find 'dot'. Please install graphviz from http://www.graphviz.org/";
}

WriteMakefile
(
 NAME         => 'GraphViz',
 VERSION_FROM => 'lib/GraphViz.pm',
 LICENSE      => 'perl',
 AUTHOR       => 'Leon Brocard <acme@astray.com>',
 ABSTRACT     => 'Interface to the GraphViz graphing tool',
 PREREQ_PM    =>
 {
	 Carp              => 1.17,
	 Config            => undef,
	 File::Which       => 1.09,
	 Getopt::Long      => 2.38,
	 IO::Dir           => 1.07,
	 IO::File          => 1.14,
	 IPC::Run          => 0.6,
	 LWP::Simple       => 6.00,
	 Parse::RecDescent => 1.965001,
	 Pod::Usage        => 1.36,
	 strict            => 1.04,
 	 Test::More        => 0.94,
 	 Test::Pod         => 1.44,
	 Time::HiRes       => 1.9724,
	 vars              => 1.01,
	 warnings          => 1.09,
	 XML::Twig         => 3.38,
	 XML::XPath        => 1.13,
 },
 dist =>
 {
	 COMPRESS => 'gzip -9f',
	 SUFFIX => 'gz',
 },
);
