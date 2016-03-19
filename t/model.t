#!perl -T

use warnings;
use strict;
use Test::More tests => 6;


BEGIN {
    use_ok( 'Games::LatticeGenerator::Geometry::Point' );
	use_ok( 'Games::LatticeGenerator::Geometry::Stretch' );
	use_ok( 'Games::LatticeGenerator::Geometry::IsoscelesTrapezoid' );	
	use_ok( 'Games::LatticeGenerator::Geometry::Solid' );		
	use_ok( 'Games::LatticeGenerator::Model' );
}


my $a = Games::LatticeGenerator::Geometry::Point->new(name => "a");
my $b = Games::LatticeGenerator::Geometry::Point->new(name => "b");
my $c = Games::LatticeGenerator::Geometry::Point->new(name => "c");
my $d = Games::LatticeGenerator::Geometry::Point->new(name => "d");


my $ab = Games::LatticeGenerator::Geometry::Stretch->new(name => "ab", points => [$a, $b], length => 1);
my $bc = Games::LatticeGenerator::Geometry::Stretch->new(name => "bc", points => [$b, $a], length => 1);
my $cd = Games::LatticeGenerator::Geometry::Stretch->new(name => "cd", points => [$c, $d], length => 2);
my $da = Games::LatticeGenerator::Geometry::Stretch->new(name => "da", points => [$d, $a], length => 1);

my $abcd = Games::LatticeGenerator::Geometry::IsoscelesTrapezoid->new(name => "abcd", edges => [$ab,$bc,$cd,$da],
																	  base_lower => $cd, base_upper => $ab);
my $body = Games::LatticeGenerator::Geometry::Solid->new(name => "alpha_body",
		planes => [ $abcd ]);

my $m = Games::LatticeGenerator::Model->new(name => "alpha", solids => [$body]);
$m->add_knowledge_about_solids();

ok(grep { /alpha_body/ } $m->get_solution(__LINE__, "X", "belongs_to(X, alpha)"), "alpha_body belongs to alpha");
