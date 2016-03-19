package Games::LatticeGenerator::ObjectWithName;

use strict;
use warnings;
use Carp;
use overload '""' => \&get_name;

sub new
{
	my $class = shift;
	my $this = { @_ };
	bless $this, $class;
	croak "missing name" unless $$this{name};
	return $this;
}


sub get_name 
{	
	return $_[0]->{name}; 
}


1;
