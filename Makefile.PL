use 5.006;
use strict;
use warnings;

use Config;

use ExtUtils::MakeMaker;

# ----------------

if ($^O eq 'MSWin32') {
	require File::Which;
	if (!File::Which::which('dot'))
	{
		print "Please install Graphviz from http://www.graphviz.org/.\n";
		exit;
	}
} else {
	if (open my $fh, '|dot', )
	{
		close $fh;
	}
	else
	{
		print "Please install Graphviz from http://www.graphviz.org/.\n";
		exit;
	}
}

my(%params) =
(
	($] ge '5.005') ?
	(
		AUTHOR   => 'Leon Brocard <acme@astray.com>',
		ABSTRACT => "Interface to AT&T's GraphViz. Deprecated. See GraphViz2",
	) : (),
	clean =>
	{
		FILES => 'blib/* Makefile MANIFEST GraphViz-*'
	},
	dist =>
	{
		'COMPRESS' => 'gzip -9f',
		'SUFFIX' => 'gz',
	},
	DISTNAME  => 'GraphViz',
	LICENSE   => 'artistic_2',
	NAME      => 'GraphViz',
	PREREQ_PM =>
	{
		'Carp' => 1.01,
		'Config' => 0,
		'File::Which' => 1.09,
		'Getopt::Long' => 2.34,
		'IO::Dir' => 1.04,
		'IO::File' => 1.10,
		'IPC::Run' => 0.6,
		'lib' => 0,
		'LWP::Simple' => 6.00,
		'Parse::RecDescent' => 1.965001,
		'Pod::Usage' => 1.16,
		'strict' => 0,
		'Test::More' => 1.001014,
		'Test::Pod' => 1.48,
		'Time::HiRes' => 1.51,
		'vars' => 0,
		'warnings' => 0,
		'XML::Twig' => 3.38,
		'XML::XPath' => 1.13,
	},
	VERSION_FROM => 'lib/GraphViz.pm',
);

if ( ($ExtUtils::MakeMaker::VERSION =~ /^\d\.\d\d$/) && ($ExtUtils::MakeMaker::VERSION > 6.30) )
{
	$params{LICENSE} = 'artistic_2';
}

if ($ExtUtils::MakeMaker::VERSION ge '6.46')
{
	$params{META_MERGE} =
	{
		resources =>
		{
			'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html?Name=GraphViz',
			'license' => 'http://opensource.org/licenses/Artistic-2.0',
		},
	};
}

WriteMakefile(%params);
