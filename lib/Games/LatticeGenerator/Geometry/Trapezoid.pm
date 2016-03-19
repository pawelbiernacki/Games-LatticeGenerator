package Games::LatticeGenerator::Geometry::Trapezoid;
use strict;
use warnings;
use Games::LatticeGenerator::Geometry::Polygon;
use Carp;
use base 'Games::LatticeGenerator::Geometry::Polygon';


sub new
{
	my $class = shift;
	my $this = $class->SUPER::new(@_);
	
	$$this{description} .=<<DESCRIPTION;
is_a_Trapezoid($$this{name}).
DESCRIPTION

	$this->add_knowledge_about_internal_angles();
	return $this;
}

sub add_knowledge_about_internal_angles
{
	croak "should be redefined";
}


sub get_amount_of_edges
{
	return 4;
}

1;
