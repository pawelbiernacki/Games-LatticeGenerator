package Games::LatticeGenerator::Geometry::Quadrangle;
use strict;
use warnings;
use Games::LatticeGenerator::Geometry::Point;
use Games::LatticeGenerator::Geometry::Stretch;
use Games::LatticeGenerator::Geometry::Polygon;
use base 'Games::LatticeGenerator::Geometry::Polygon';


sub new
{
	my $class = shift;
	my $this = $class->SUPER::new(@_);
	
	$$this{description} .=<<DESCRIPTION;
is_a_Quadrangle($$this{name}).
DESCRIPTION

	$this->add_knowledge_about_internal_angles();
	return $this;
}

sub add_knowledge_about_internal_angles
{
	my $this = shift;
	for my $w (keys %{$$this{internal_angles}})
	{
		$$this{description}.= <<DESCRIPTION;
is_an_InternalAngle($$this{name}, $w, $$this{internal_angles}{$w}).
DESCRIPTION
	}
}


sub get_amount_of_edges
{
	return 4;
}

1;
