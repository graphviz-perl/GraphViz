#!perl
use strict;
use warnings;
use Config;
use ExtUtils::MakeMaker;
use File::Spec::Functions;

print "Looking for dot... ";
my $found = find("dot");

if ($found) {
    print "found it at $found\n";
} else {
    print "didn't find it\n";
    die "****************************************************************
GraphViz.pm has not been able to find the graphviz program 'dot'
GraphViz.pm needs graphviz to function
Please install graphviz first: http://www.graphviz.org/
****************************************************************\n";
}

WriteMakefile(
    'NAME'         => 'GraphViz',
    'VERSION_FROM' => 'lib/GraphViz.pm',
    'LICENSE'      => 'perl',
    'AUTHOR'       => 'Leon Brocard <acme@astray.com>',
    'ABSTRACT'     => 'Interface to the GraphViz graphing tool',
    'PREREQ_PM'    => {
        'IPC::Run'   => 0.6,
        'Test::More' => 0,
    },
    'dist' => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);

sub find {
    my $binary   = shift;
    my $path     = join ', ', @ENV{PATH};
    my $path_sep = $Config{path_sep};
    my $exe_ext  = $Config{exe_ext};
    foreach my $dir ( split $path_sep, @ENV{PATH} ) {
        my $filename = catfile( $dir, $binary );
        return $filename if -x "$filename$exe_ext";
    }
    return 0;
}
