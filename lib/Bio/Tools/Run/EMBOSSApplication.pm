# $Id$
#
# BioPerl module for Bio::Tools::Run::EMBOSSApplication
#
# Copyright Heikki Lehvaslaiho
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::EMBOSSApplication - class for EMBOSS Applications

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
  my $seq_to_test;     # this would have a seq here
  my @seqs_to_check; # this would be a list of seqs to compare 

  my $wateroutfile = 'out.water';
  $water->run({-sequencea => $seq_to_test,
               -seqall    => \@seqs_to_check,
               -gapopen   => '10.0',
               -gapextend => '0.5',
               -outfile   => $wateroutfile});
  # now you might want to get the alignment
  use Bio::AlignIO;
  my $alnin = Bio::AlignIO->new(-format => 'emboss',
			                      -file   => $wateroutfile);

  while ( my $aln = $alnin->next_aln ) {
      # process the alignment -- these will be Bio::SimpleAlign objects
  }

=head1 DESCRIPTION

The EMBOSSApplication class can represent EMBOSS any program. It is
created by a L<Bio::Factory::EMBOSS> object.

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

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Heikki Lehvaslaiho

Email  heikki-at-bioperl-dot-org

=head2 CONTRIBUTORS

Email: jason-AT-bioperl_DOT_org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::Tools::Run::EMBOSSApplication;
use vars qw( $SEQIOLOADED $ALIGNIOLOADED );
use strict;
use Data::Dumper;
use Bio::Tools::Run::EMBOSSacd;
use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

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
	$self->debug( Dumper($input) );

	# parse ACD information
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
				my $out = Bio::SeqIO->new(-format => 'fasta',
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
				my $out = Bio::AlignIO->new(-format => 'msf',
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

	# check mandatory attributes against given ones
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
	$self->debug( "Command line: ", $runstring, "\n"); 
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

=head2 program_dir

 Title   : program_dir
 Usage   :
 Function: Required by WrapperBase
 Throws  :
 Returns : Name of directory with EMBOSS programs
 Args    :

=cut

sub program_dir {
	return Bio::Root::IO->catfile($ENV{EMBOSS_ACDROOT});
}

=head2 program_path

 Title   : program_path
 Usage   :
 Function: Required by WrapperBase
 Throws  :
 Returns : Full path of program
 Args    :

=cut

sub program_path {
	my $self = shift;
	my $name = $self->{_name};
	my $dir = Bio::Root::IO->catfile($ENV{EMBOSS_ACDROOT});
	return "$dir/$name";
}

=head2 executable

 Title   : executable
 Usage   :
 Function: Required by WrapperBase
 Throws  :
 Returns : Name of program
 Args    :

=cut

sub executable {
	my $self = shift;
	$self->{_name};
}

1;
