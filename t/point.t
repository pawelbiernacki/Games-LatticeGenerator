#!perl -T

use warnings;
use strict;
use Test::More tests => 3;

BEGIN {
    use_ok( 'Games::LatticeGenerator::Geometry::Point' );
}

my $p = Games::LatticeGenerator::Geometry::Point->new(name => "a");

ok($$p{description} =~ /is_a_Point\(a\)/, 'description contains fact is_a_Point(a)');
ok(grep { /a/ } $p->get_solution(__LINE__, "X", "is_a_Point(X)"), 'solution contains a');

