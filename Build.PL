use strict;
use warnings;

use Module::Build;

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

Module::Build -> new
(
	module_name    => 'GraphViz',
	license        => 'artistic_2',
	dist_abstract  => "Interface to AT&T's GraphViz. Deprecated. See GraphViz2",
	dist_author    => 'Leon Brocard <acme@astray.com>',
	build_requires =>
	{
		'Test::More' => 1.001014,
		'Test::Pod' => 1.48,
	},
	configure_requires =>
	{
		'Module::Build' => 0.4211,
		'File::Which' => 1.09,
	},
	meta_merge =>
	{
		resources =>
		{
		'repository' => 'https://github.com/ronsavage/GraphViz',
		'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html?Name=GraphViz',
		'license' => 'http://opensource.org/licenses/Artistic-2.0',
		},
	},
	requires =>
	{
		'Carp' => 1.01,
		'Config' => 0,
		'Getopt::Long' => 2.34,
		'IO::Dir' => 1.04,
		'IO::File' => 1.10,
		'IPC::Run' => 0.6,
		'lib' => 0,
		'LWP::Simple' => 6.00,
		'Parse::RecDescent' => 1.965001,
		'Pod::Usage' => 1.16,
		'strict' => 0,
		'Time::HiRes' => 1.51,
		'vars' => 0,
		'warnings' => 0,
		'XML::Twig' => 3.38,
		'XML::XPath' => 1.13,
		'perl' => 5.006,
	},
) -> create_build_script();
