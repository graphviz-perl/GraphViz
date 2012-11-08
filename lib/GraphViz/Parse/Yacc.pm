package GraphViz::Parse::Yacc;

use strict;
use warnings;
use vars qw($VERSION);
use Carp;
use lib '../..';
use lib '..';
use GraphViz;

our $VERSION = '2.12';

=head1 NAME

GraphViz::Parse::Yacc - Visualise grammars

=head1 SYNOPSIS

  use GraphViz::Parse::Yacc;

  # Pass in a file generated via yacc -v
  my $graph = GraphViz::Parse::Yacc->new('Yacc.output');
  print $g->as_png;


=head1 DESCRIPTION

This module makes it easy to visualise Parse::Yacc grammars.
Writing Parse::Yacc grammars is tricky at the best of times, and
grammars almost always evolve in ways unforseen at the start. This
module aims to visualise a grammar as a graph in order to make the
structure clear and aid in understanding the grammar.

Rules are represented as nodes, which have their name on the left of
the node and their productions on the right of the node. The subrules
present in the productions are represented by edges to the subrule
nodes.

Thus, every node (rule) should be connected to the graph - otherwise a
rule is not part of the grammar.

This uses the GraphViz module to draw the graph. Thanks to Damian
Conway for the original idea.

=head1 METHODS

=head2 new

This is the constructor. It takes one mandatory argument, which is a
filename of the output file generated by running "yacc -v " on the
grammar file. For example, if your Parse::Yacc grammar file is called
"calc.yp", you would run "yacc -v calc.y" and pass in "calc.output"
as an argument here. A GraphViz object is returned.

  # Pass in a file generated via yacc -v
  my $graph = GraphViz::Parse::Yacc->new('Yacc.output');
  print $g->as_png;

=cut

sub new {
    my $proto    = shift;
    my $class    = ref($proto) || $proto;
    my $filename = shift;

    return _init($filename);
}

=head2 as_*

The grammar can be visualised in a number of different graphical
formats. Methods include as_ps, as_hpgl, as_pcl, as_mif, as_pic,
as_gd, as_gd2, as_gif, as_jpeg, as_png, as_wbmp, as_ismap, as_imap,
as_vrml, as_vtx, as_mp, as_fig, as_svg. See the GraphViz documentation
for more information. The two most common methods are:

  # Print out a PNG-format file
  print $g->as_png;

  # Print out a PostScript-format file
  print $g->as_ps;

=cut

sub _init {
    my $filename = shift;
    my ( @links, %edges, %labels, %is_rule );
    my $graph = GraphViz->new( concentrate => 1 );

    open( IN, $filename ) || carp("Couldn't read file $filename");
    my $rule;

    foreach my $line (<IN>) {
        chomp $line;
        next unless $line =~ /\w/;
        next unless $line =~ s/^\s+\d+\s+//;

        if ( $line =~ s/([^ ]+) : ?// ) {
            $rule = $1;
        }

        $line =~ s/\|\s+//;

        my $text = $line;
        $is_rule{$rule}++;

        $text = "(empty)" if $text =~ /^\s*$/;

        my $rule_label;
        foreach my $item ( split ' ', $text ) {
            $edges{$rule}{$item}++;
            $rule_label .= $item . " ";
        }
        $rule_label .= '\n';
        $labels{$rule} .= $rule_label;
    }

    foreach my $from ( keys %edges ) {
        next unless $is_rule{$from};
        foreach my $to ( keys %{ $edges{$from} } ) {
            next unless $is_rule{$to};
            $graph->add_edge( $from => $to );
        }
    }

    foreach my $rule ( keys %labels ) {
        $graph->add_node( $rule, label => [ $rule, $labels{$rule} ] );
    }

    close(IN);
    return $graph;
}

=head1 AUTHOR

Leon Brocard E<lt>F<acme@astray.com>E<gt>

=head1 COPYRIGHT

Copyright (C) 2001, Leon Brocard

This module is free software; you can redistribute it or modify it
under the same terms as Perl itself.

=cut

1;
