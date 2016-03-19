package Games::LatticeGenerator::ObjectDescribedByFacts;

use strict;
use warnings;
use AI::Prolog;
use Games::LatticeGenerator::ObjectWithName;
use Carp;
use Capture::Tiny ':all';
use base 'Games::LatticeGenerator::ObjectWithName';

sub new
{
	my $class = shift;
	my $this = $class->SUPER::new(@_);
	
	my $s = $class;
	$s =~ s/([\w]+::)+//;
	$$this{description} = <<DESCRIPTION;	
is_a_${s}($this).
DESCRIPTION

	return $this;
}

sub get_unique
{
	my $this = shift;
	my %k;
	$k{$_} = 1 for @_;
	return sort keys %k;
}

sub get_description
{
	my $this = shift;
	croak "empty object" unless defined $this;
	return join("", $this->get_unique(map { "$_\n" } grep { $_ } sort split /\n/, $this->{description}));
}

our $common_knowledge = "";

sub get_solution
{
	my $this = shift;
	my $line = shift;
	my $original_code = $this->get_description();
	my $code = "";

	my $variable = shift;
	my $condition = shift;
	my $optional_context = shift;

	$optional_context = "" unless defined($optional_context);

	my $new_code = $original_code."\n".$optional_context;

	$code .= <<CODE;
$common_knowledge
$new_code
goal:- $condition, write($variable), nl, fail.
goal.
CODE

	my $p = AI::Prolog->new($code);
	
		
	my @result = split /\n/, capture_stdout { $p->query("goal"); $p->results(); };

	return $this->get_unique(@result);		
}

sub get_solution_n
{
	my $this = shift;
	my $line = shift;
	my $original_code = $this->get_description();
	my $code = "";

	my $variables_ref = shift;
	my $condition = shift;
	my $optional_context = shift;

	$optional_context = "" unless defined($optional_context);

	my $new_code = $original_code."\n".$optional_context;

	my $write_the_variables = join(", write(' '), ", map { "write($_)" } @$variables_ref);

	$code .= <<CODE;
$common_knowledge
$new_code
goal:- $condition, $write_the_variables, nl, fail.
goal.
CODE
	
	my $p = AI::Prolog->new($code);

	my @result = split /\n/, capture_stdout { $p->query("goal"); $p->results(); };

	return $this->get_unique(@result);
}



sub get_stretches_whose_vertex_is_the_point
{
	my $this = shift;
	my $point = shift;
	return $this->get_solution(__LINE__,"X", "is_a_Vertex($$point{name},X), is_a_Stretch(X)",<<CONTEXT);

is_a_Vertex(P,X):-is_a_Point(P), belongs_to(P,X).

CONTEXT
}


sub get_polygons_whose_vertex_is_the_point
{
	my $this = shift;
	my $point = shift;

	croak "empty point" unless $point;
	
	return $this->get_solution(__LINE__,"X", "is_a_Point($$point{name}), belongs_to($$point{name}, EDGE), belongs_to(EDGE, X), is_a_Polygon(X)");
}



1;
