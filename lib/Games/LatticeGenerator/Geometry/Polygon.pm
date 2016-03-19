package Games::LatticeGenerator::Geometry::Polygon;
use strict;
use warnings;
use Games::LatticeGenerator::ObjectDescribedByFacts;
use base 'Games::LatticeGenerator::ObjectDescribedByFacts';


sub new
{
	my $class = shift;
	my $this = $class->SUPER::new(@_);	
	die "missing edges" unless $this->get_amount_of_edges() == grep { defined($_) } map { $$this{edges}[$_] } 0..$this->get_amount_of_edges()-1;

	$$this{description} .= join("", map { 
<<DESCRIPTION
$$this{edges}[$_]{description}
belongs_to($$this{edges}[$_]{name}, $this).
DESCRIPTION
} 0..$this->get_amount_of_edges()-1);

	$$this{description} .= <<DESCRIPTION;
is_a_Polygon($$this{name}).
DESCRIPTION

	return $this;
}

1;
