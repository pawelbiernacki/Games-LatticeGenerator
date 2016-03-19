#!perl -T

use warnings;
use strict;
use Test::More tests => 6;


BEGIN {
    use_ok( 'Games::LatticeGenerator::Geometry::Point' );
	use_ok( 'Games::LatticeGenerator::Geometry::Stretch' );
}

my $a = Games::LatticeGenerator::Geometry::Point->new(name => "a");
my $b = Games::LatticeGenerator::Geometry::Point->new(name => "b");
my $ab = Games::LatticeGenerator::Geometry::Stretch->new(name => "ab", points => [$a, $b], length => 1.5);

ok($$ab{description} =~ /is_a_Stretch\(ab\)/, 'description contains fact is_a_Stretch(ab)');
ok(grep { /ab/ } $ab->get_solution(__LINE__, "X", "is_a_Stretch(X)"), 'solution contains ab');
ok($$ab{description} =~ /belongs_to\(a, ab\)/, 'description contains fact belongs_to(a,ab)');
ok($$ab{description} =~ /has_length\(ab, 1\.5\)/, 'description contains fact has_length(ab, 1.5)');
