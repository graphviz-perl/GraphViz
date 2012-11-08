use Config;

use ExtUtils::MakeMaker;

if (open my $fh, '|dot', )
{
	close $fh;
}
else
{
	die "Please install Graphviz from http://www.graphviz.org/.\n";
}

WriteMakefile
(
 NAME         => 'GraphViz',
 VERSION_FROM => 'lib/GraphViz.pm',
 LICENSE      => 'perl',
 AUTHOR       => 'Leon Brocard <acme@astray.com>',
 ABSTRACT     => "Interface to AT&T's GraphViz. Deprecated. See GraphViz2",
 PREREQ_PM    =>
 {
	 Carp              => 1.01,
	 Config            => 0,
	 File::Which       => 1.09,
	 Getopt::Long      => 2.34,
	 IO::Dir           => 1.04,
	 IO::File          => 1.10,
	 IPC::Run          => 0.6,
	 LWP::Simple       => 6.00,
	 Parse::RecDescent => 1.965001,
	 Pod::Usage        => 1.16,
	 strict            => 0,
 	 Test::More        => 0.47,
 	 Test::Pod         => 1.44,
	 Time::HiRes       => 1.51,
	 vars              => 0,
	 warnings          => 0,
	 XML::Twig         => 3.38,
	 XML::XPath        => 1.13,
 },
 dist =>
 {
	 COMPRESS => 'gzip -9f',
	 SUFFIX => 'gz',
 },
);
