 # $Id$
#
# BioPerl module for Bio::Tools::Run::EMBOSSApplication
#
#
# Cared for by Heikki Lehvaslaiho <heikki@ebi.ac.uk>
#
# Copyright Heikki Lehvaslaiho
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::EMBOSSApplication -  class for EMBOSS Applications

=head1 SYNOPSIS

  use Bio::Factory::EMBOSS;
  # get an EMBOSS application object from the EMBOSS factory
  $factory = new Bio::Factory::EMBOSS;
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
  $water->run({ '-sequencea' => $seq_to_test,
              '-seqall'    => \@seqs_to_check,
              '-gapopen'   => '10.0',
              '-gapextend' => '0.5',
              '-outfile'   => $wateroutfile});
  # now you might want to get the alignment
  use Bio::AlignIO;
  my $alnin = new Bio::AlignIO(-format => 'emboss',
			       -file   => $wateroutfile);

  while( my $aln = $alnin->next_aln ) {
      # process the alignment -- these will be Bio::SimpleAlign objects
  }

=head1 DESCRIPTION

The EMBOSSApplication class can represent EMBOSS any program. It is
created by a Bio::Factory::EMBOSS object.

If you want to check command line options before sending them to the
program set $prog-E<gt>verbose to positive integer. The ADC
description of the available command line options is then parsed in
and compared to input.

See also L<Bio::Factory::EMBOSS> and L<Bio::Tools::Run::EMBOSSacd>.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to the
Bioperl mailing lists  Your participation is much appreciated.

  bioperl-l@bioperl.org                         - General discussion
  http://bio.perl.org/MailList.html             - About the mailing lists

=head2 Reporting Bugs

report bugs to the Bioperl bug tracking system to help us keep track
 the bugs and their resolution.  Bug reports can be submitted via
 email or the web:

  bioperl-bugs@bio.perl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR - Heikki Lehvaslaiho

Email:  heikki@ebi.ac.uk
Address:

     EMBL Outstation, European Bioinformatics Institute
     Wellcome Trust Genome Campus, Hinxton
     Cambs. CB10 1SD, United Kingdom

=head2 CONTRIBUTORS

Email: jason@bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::Tools::Run::EMBOSSApplication;
use vars qw(@ISA $SEQIOLOADED $ALIGNIOLOADED);
use strict;
use Data::Dumper;
use Bio::Root::Root;
use Bio::Tools::Run::EMBOSSacd;
use Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

sub new {
  my($class, $args) = @_;
  my $self = $class->SUPER::new();

  $self->name($args->{'name'});
  $self->verbose($args->{'verbose'});

  $self->acd if $self->verbose > 0;

  return $self;
}

=head2 run

 Title   : run
 Usage   : $embossapplication->run($attribute_hash)
 Function: Runs the EMBOSS program.
 Returns : string or creates files for now; will return objects!
 Args    : hash of input to the program

=cut

sub run {
    my ($self, $input) = @_;
    $self->io->_io_cleanup();
    # test input
    $self->debug( Dumper($input) ) if $self->verbose > 0;

    #parse ACD information
    $self->acd if $self->verbose > 0;

    # collect the options into a string
    my $option_string = '';
    foreach my $attr (keys %{$input}) {
	my $attr_name = substr($attr, 1) if substr($attr, 0, 1) =~ /\W/;

	my $array = 0;

	if( defined $input->{$attr} && ref($input->{$attr}) ) {

	    my (@pieces);

	    if( $array = (ref($input->{$attr}) =~ /array/i) ) {
		foreach my $s ( @{$input->{$attr}} ) {
		    @pieces = @{$input->{$attr}};
		}
	    } else {
		@pieces = ($input->{$attr});
	    }
	    if( ! defined $pieces[0] ) {
		# we ignore for now
		$self->warn("specified a parameter $attr with no value");
		$input->{$attr} = undef;
		return;
	    } elsif( $pieces[0]->isa('Bio::PrimarySeqI') ) {
		unless(  $SEQIOLOADED ) { 
		    require Bio::SeqIO;
		    $SEQIOLOADED = 1;
		}
		my ($tfh,$tempfile) = $self->io->tempfile(-dir => $self->tempdir);
		my $out = new Bio::SeqIO(-format => 'fasta',
					 -fh     => $tfh);
		foreach my $seq ( @pieces ) {
		    $out->write_seq($seq);
		}
		$out->close();
		$input->{$attr} = $tempfile;
		close($tfh);
		undef $tfh;
	    } elsif( $pieces[0]->isa('Bio::Align::AlignI') ) {
		unless(  $ALIGNIOLOADED ) { 
		    require Bio::AlignIO;
		    $ALIGNIOLOADED = 1;
		}
		my ($tfh,$tempfile) = $self->io->tempfile();
		my $out = new Bio::AlignIO(-format => 'msf',
					   -fh     => $tfh);
		foreach my $p ( @pieces ) {
		    $out->write_aln($p);
		}
		$input->{$attr} = $tempfile;
		close($tfh);
		undef $tfh;
	    }
	}

	# check each argument against ACD
	if ($self->verbose > 0) {

	    last unless defined $self->acd; # might not have the parser

	    $self->throw("Attribute [$attr] not recognized!\n")
		unless $self->acd->qualifier($attr);
	}

	# print out debugging info
	$self->debug("Input attr: ". $attr_name. " => ".
		     $input->{$attr}. "\n");
	$option_string .= " " . $attr;
	$option_string .= " ". $input->{$attr}
	   if defined $input->{$attr};
    }

    #check mandatory attributes against given ones
    if ($self->verbose > 0) {
	last unless defined $self->acd; # might not have the parser
#	$self->acd->mandatory->print;
#	if ($self->name eq 'water') {
#	    print Dumper($self->acd->mandatory);
#	}
	foreach my $attr (keys %{$self->acd->mandatory} ) {
	    last unless defined $self->acd; # might not have the parser
	    unless (defined $input->{$attr}) {
		print "-" x 38, "\n", "MISSING MANDATORY ATTRIBUTE: $attr\n", 
		    "-" x 38, "\n";
		$self->acd->print($attr) and
		$self->throw("Program ". $self->name.
			 " needs attribute [$attr]!\n")
	    }
	}
    }
    my $runstring = join (' ', $self->name, $option_string, '-auto');
    print STDERR "Command line: ", $runstring, "\n" if $self->verbose > 0;
    return `$runstring`;
}

=head2 acd

 Title   : acd
 Usage   : $embossprogram->acd
 Function: finds out all the possible qualifiers for this
           EMBOSS application. They can be used to debug the
           options given.
 Throws  : 
 Returns : boolean
 Args    : 

=cut

sub acd {
    my ($self) = @_;
    unless ( $self->{'_acd'} ) {
	$self->{'_acd'} =
	    Bio::Tools::Run::EMBOSSacd->new($self->name);
    }
    return $self->{'_acd'};
}

=head2 name

 Title   : name
 Usage   : $embossprogram->name
 Function: sets/gets the name of the EMBOSS program
           Setting is done by the EMBOSSFactory object,
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


=head2 descr

 Title   : descr
 Usage   : $embossprogram->descr
 Function: sets/gets the descr of the EMBOSS program
           Setting is done by the EMBOSSFactory object,
           you should only get it.
 Throws  : 
 Returns : description string
 Args    : None

=cut

sub descr {
    my ($self,$value) = @_;
    if (defined $value) {
	$self->{'_descr'} = $value;
    }
    return $self->{'_descr'};
}


=head2 group

 Title   : group
 Usage   : $embossprogram->group
 Function: sets/gets the group of the EMBOSS program
           Setting is done by the EMBOSSFactory object,
           you should only get it.

           If the application is assigned into a subgroup
           use l<subgroup> to get it.

 Throws  : 
 Returns : string, group name
 Args    : group string

=cut

sub group {
    my ($self,$value) = @_;
    if (defined $value) {
	my ($group, $subgroup) = split ':', $value;
	$self->{'_group'} = $group;
	$self->{'_subgroup'} = $subgroup;
    }
    return $self->{'_group'};
}


=head2 subgroup

 Title   : subgroup
 Usage   : $embossprogram->subgroup
 Function: sets/gets the subgroup of the EMBOSS program
           Setting is done by the EMBOSSFactory object,
           you should only get it.
 Throws  : 
 Returns : string, subgroup name; undef if not defined
 Args    : None

=cut

sub subgroup {
    my ($self) = @_;
    return $self->{'_subgroup'};
}




1;
