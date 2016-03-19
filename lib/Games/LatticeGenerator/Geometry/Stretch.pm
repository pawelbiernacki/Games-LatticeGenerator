package Games::LatticeGenerator::Geometry::Stretch;
use strict;
use warnings;
use Games::LatticeGenerator::Geometry::Point;
use Games::LatticeGenerator::ObjectDescribedByFacts;
use base 'Games::LatticeGenerator::ObjectDescribedByFacts';
use Carp;


sub new
{
	my $class = shift;
	my $this = $class->SUPER::new(@_);	
	croak "missing points" unless 2 == grep { defined($_) } map { $$this{points}[$_] } 0..1;
	
	croak "missing length" unless defined($$this{length});
	
	croak "length cannot be negative ($$this{length}) " unless $$this{length}>=0.0;

	$$this{description} .= join("", map { 
<<OPIS
$$this{points}[$_]{description}
belongs_to($$this{points}[$_]{name}, $this).
has_length($$this{name}, $$this{length}).
OPIS
} 0..1);
	
	return $this;
}

1;