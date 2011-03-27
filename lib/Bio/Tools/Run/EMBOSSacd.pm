# $Id$
#
# BioPerl module for Bio::Tools::Run::EMBOSSacd
#
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Heikki Lehvaslaiho <heikki-at-bioperl-dot-org>
#
# Copyright Heikki Lehvaslaiho
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::EMBOSSacd - class for EMBOSS Application qualifiers

=head1 SYNOPSIS

  use Bio::Factory::EMBOSS;
  # get an EMBOSS application object from the EMBOSS factory
  $factory = Bio::Factory::EMBOSS->new();
  $application = $factory->program('embossversion');
  # run the application with an optional hash containing parameters
  $result = $application->run(); # returns a string or creates a file
  print $result . "\n";

  $water = $factory->program('water');

  # here is an example of running the application
  # water can compare 1 seq against 1->many sequences
  # in a database using Smith-Waterman
  my $seq_to_test; # this would have a seq here
  my @seqs_to_check; # this would be a list of seqs to compare 
                     # (could be just 1)
  my $wateroutfile = 'out.water';
  $water->run({ -sequencea => $seq_to_test,
                -seqall    => \@seqs_to_check,
                -gapopen   => '10.0',
                -gapextend => '0.5',
                -outfile   => $wateroutfile});
  # now you might want to get the alignment
  use Bio::AlignIO;
  my $alnin = Bio::AlignIO->new(-format => 'emboss',
			                      -file   => $wateroutfile);

  while( my $aln = $alnin->next_aln ) {
      # process the alignment -- these will be Bio::SimpleAlign objects
  }

=head1 DESCRIPTION

The EMBOSSacd represents all the possible command line arguments that
can be given to an EMBOSS application.

Do not create this object directly. It will be created and attached to
its corresponding Bio::Tools::Run::EMBOSSApplication if you set

  $application->verbose > 0

Call

  $application->acd

to retrive the Bio::Tools::Run::EMBOSSApplication::EMBOSSacd object.

See also L<Bio::Tools::Run::EMBOSSApplication> and L<Bio::Factory::EMBOSS>.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to the
Bioperl mailing lists  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Heikki Lehvaslaiho

Email:  heikki-at-bioperl-dot-org
Address:

     EMBL Outstation, European Bioinformatics Institute
     Wellcome Trust Genome Campus, Hinxton
     Cambs. CB10 1SD, United Kingdom

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::Tools::Run::EMBOSSacd;
use vars qw(@ISA %QUALIFIER_CATEGORIES $QUAL %OPT);

use strict;
use Data::Dumper;
use Bio::Root::Root;

@ISA = qw(Bio::Root::Root);

BEGIN {

    %QUALIFIER_CATEGORIES = 
	(
	 'Mandatory qualifiers'            => 'mandatory',
	 'Standard (Mandatory) qualifiers' => 'mandatory',
	 'Optional qualifiers'             => 'optional',
	 'Additional (Optional) qualifiers'=> 'optional',
	 'Advanced qualifiers'             => 'advanced',
	 'Advanced (Unprompted) qualifiers'=> 'advanced',
	 'Associated qualifiers'           => 'associated',
	 'General qualifiers'              => 'general',
	);
    $QUAL;			# qualifier category

}


=head2 new

 Title   : new
 Usage   : $emboss_prog->acd($prog_name);
 Function: Constructor for the class.
           Calls EMBOSS program 'acdc', converts the
           HTML output into XML and uses XML::Twig XML 
           parser to write out a hash of qualifiers which is
           then blessed.
 Throws  : without program name
 Returns : new object
 Args    : EMBOSS program name

=cut


sub new {
    my($class, $prog) = @_;

    eval {require XML::Twig;};
    Bio::Root::Root->warn("You need XML::Twig for EMBOSS ACD parsing")
	    and return undef if $@;

    Bio::Root::Root->throw("Need EMBOSSprogram name as an argument")
	     unless $prog;
    # reset global hash
    %OPT = ();

    my $version = `embossversion -auto`;
    my $file;
    if ($version lt "2.8.0") {
	# reading from EMBOSS program acdc stdout (prior to version 2.8.0)
	$file = `acdc $prog -help -verbose -acdtable 2>&1`;
    } else {
	# reading from EMBOSS program acdtable stdout (version 2.8.0 or greater)
	$file = `acdtable $prog -help -verbose 2>&1`;
    }
    
    # converting HTML -> XHTML for XML parsing
    $file =~ s/border/border="1"/;
    $file =~ s/=(\d+)/="$1"/g;
    $file =~ s/<br>/<br><\/br>/g;
    $file =~ s/&nbsp;//g;

    my $t = XML::Twig->new( TwigHandlers =>
			   {
			       '/table/tr' => \&_row  }
			   );
    
    $t->safe_parse( $file);
    
    #Bio::Root::Root->throw("XML parsing error: $@");
    
    my %acd = %OPT; # copy to a private hash
    $acd{'_name'} = $prog;
    bless \%acd, $class;
}

sub _row {
    my ($t, $row)= @_;

    return if $row->text eq "(none)"; #  no qualifiers in this category

    my $name = $row->first_child; # qualifier name

    my $namet = $name->text;
    if ($namet =~ /qualifiers$/) { # set category
	$QUAL = $QUALIFIER_CATEGORIES{$namet};
	if( ! defined $QUAL ) { 
	    warn("-- namet is $namet\n");
	}
	return;
    }
    my $unnamed = 0;
    if ($namet =~ /\(Parameter (\d+)\)/) { # unnamed parameter
	$unnamed = $1;
	$namet =~ s/\(Parameter (\d+)\)//;
	$namet =~ s/[\[\]]//g ; # name is in brackets
    }

    my $desc = $name->next_sibling;
    my $values = $desc->next_sibling;
    my $default = $values->next_sibling;

    $OPT{$namet}{'unnamed'} = $unnamed;
    $OPT{$namet}{'category'} = $QUAL;
    $OPT{$namet}{'descr'} = $desc->text;
    $OPT{$namet}{'values'} = $values->text;
    $OPT{$namet}{'default'} = $default->text;

    $t->purge;			# to reduce memory requirements
}

=head2 name

 Title   : name
 Usage   : $embossacd->name
 Function: sets/gets the name of the EMBOSS program
           Setting is done by the EMBOSSApplication object,
           you should only get it.
 Throws  : 
 Returns : name string
 Args    : None

=cut

sub name {
    my ($self,$value) = @_;
    if (defined $value) {
	$self->{'_name'} = $value;
    }
    return $self->{'_name'};
}


=head2 print

 Title   : print
 Usage   : $embossacd->print; $embossacd->print('-word');
 Function: Print out the qualifiers.
           Uses Data::Dumper to print the qualifiers into STDOUT.
           A valid qualifier name given as an argment limits the output.
 Throws  : 
 Returns : print string
 Args    : optional qualifier name

=cut

sub print {
    my ($self, $value) = @_;
    if ($value and $self->{$value}) {
	print Dumper $self->{$value};
    } else {
	print Dumper $self;
    }
}

=head2 mandatory

 Title   : mandatory
 Usage   : $acd->mandatory
 Function: gets a  mandatory subset of qualifiers
 Throws  : 
 Returns : Bio::Tools::Run::EMBOSSacd object
 Args    : none

=cut

sub mandatory {
    my ($self) = @_;
    my %mand;
    foreach my $key (keys %{$self}) {
	next unless $key =~ /^-/; #ignore other attributes

	$mand{$key} = $self->{$key}
	if $self->{$key}{category} eq 'mandatory';
    }
    bless \%mand;
}

=head2 Qualifier queries

These methods can be used test qualifier names and read values.

=cut

=head2 qualifier

 Title   : qualifier
 Usage   : $acd->qualifier($string)
 Function: tests for the existence of the qualifier
 Throws  : 
 Returns : boolean
 Args    : string, name of the qualifier

=cut

sub qualifier {
    my ($self, $value) = @_;

    $self->throw("Qualifier has to start with '-'") 
	unless $value =~ /^-/;
    $self->{$value} ? 1 : 0
}

=head2 category

 Title   : category
 Usage   : $acd->category($qual_name)
 Function: Return the category of the qualifier
 Throws  : 
 Returns : 'mandatory' or 'optional' or 'advanced' or 
            'associated' or 'general'
 Args    : string, name of the qualifier

=cut

sub category {
    my ($self, $value) = @_;

    $self->throw("Not a valid qualifier name [$value]")
	unless $self->qualifier($value);
    $self->{$value}->{'category'};
}

=head2 values

 Title   : values
 Usage   : $acd->values($qual_name)
 Function: Return the possible values for the qualifier
 Throws  : 
 Returns : string
 Args    : string, name of the qualifier

=cut

sub values {
    my ($self, $value) = @_;

    $self->throw("Not a valid qualifier name [$value]")
	unless $self->qualifier($value);
    $self->{$value}->{'values'};

}

=head2 descr

 Title   : descr
 Usage   : $acd->descr($qual_name)
 Function: Return the description of the qualifier
 Throws  : 
 Returns : boolean
 Args    : string, name of the qualifier

=cut

sub descr {
    my ($self, $value) = @_;

    $self->throw("Not a valid qualifier name [$value]")
	unless $self->qualifier($value);
    $self->{$value}->{'descr'};

}

=head2 unnamed

 Title   : unnamed
 Usage   : $acd->unnamed($qual_name)
 Function: Find if the qualifier can be left unnamed
 Throws  : 
 Returns : 0 if needs to be named, order number otherwise
 Args    : string, name of the qualifier

=cut

sub unnamed {
    my ($self, $value) = @_;

    $self->throw("Not a valid qualifier name [$value]")
	unless $self->qualifier($value);
    $self->{$value}->{'unnamed'};

}

=head2 default

 Title   : default
 Usage   : $acd->default($qual_name)
 Function: Return the default value for the qualifier
 Throws  : 
 Returns : scalar
 Args    : string, name of the qualifier

=cut

sub default {
    my ($self, $value) = @_;

    $self->throw("Not a valid qualifier name [$value]")
	unless $self->qualifier($value);
    $self->{$value}->{'default'};
}


1;
