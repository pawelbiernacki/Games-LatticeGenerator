package Games::LatticeGenerator::Geometry::Solid;
use strict;
use warnings;
use Carp;
use Games::LatticeGenerator::ObjectDescribedByFacts;
use base 'Games::LatticeGenerator::ObjectDescribedByFacts';



sub new
{
	my $class = shift;
	my $this = $class->SUPER::new(@_);	
	croak "missing planes" unless $this->get_amount_of_planes() == grep { defined($_) } map { $$this{planes}[$_] } 
		0..$this->get_amount_of_planes() - 1;

	$$this{description} .= join("", map { 
<<DESCRIPTION
$$this{planes}[$_]{description}
belongs_to($$this{planes}[$_]{name}, $this).
DESCRIPTION
} 0..$this->get_amount_of_planes()-1);
	
	return $this;
}

sub get_edges
{
	my $this = shift;
	return $this->get_solution(__LINE__,"X", "is_a_Stretch(X), belongs_to(X, PLANE), is_a_Polygon(PLANE), belongs_to(PLANE, $$this{name})");
}

sub get_amount_of_planes
{
	my $this = shift;
	return scalar(@{$$this{planes}});
}

1;
