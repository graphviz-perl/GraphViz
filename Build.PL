use File::Which; # For which().

use Module::Build;

if (! which('dot') )
{
	die "Did not find 'dot'. Please install graphviz from http://www.graphviz.org/";
}

Module::Build -> new
(
 module_name    => 'GraphViz',
 license        => 'perl',
 dist_abstract  => 'Interface to the GraphViz graphing tool',
 dist_author    => 'Leon Brocard <acme@astray.com>',
 build_requires =>
 {
 	 Test::More => 0.94,
 	 Test::Pod  => 1.44,
 },
 configure_requires =>
 {
 	 Module::Build => 0.3800,
 },
 requires =>
 {
	 Carp              => 1.17,
	 Config            => undef,
	 Getopt::Long      => 2.38,
	 IO::Dir           => 1.07,
	 IO::File          => 1.14,
	 IPC::Run          => 0.6,
	 LWP::Simple       => 6.00,
	 Parse::RecDescent => 1.965001,
	 Pod::Usage        => 1.36,
	 strict            => 1.04,
	 Time::HiRes       => 1.9724,
	 vars              => 1.01,
	 warnings          => 1.09,
	 XML::Twig         => 3.38,
	 XML::XPath        => 1.13,
 },
) -> create_build_script();
