# $Id$
#
# This is the original copyright statement. I have relied on Chad's module
# extensively for this module.
#
# Copyright (c) 1997-2001 bioperl, Chad Matsalla. All Rights Reserved.
#           This module is free software; you can redistribute it and/or
#           modify it under the same terms as Perl itself. 
#
# Copyright Chad Matsalla
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code
#
# But I have modified lots of it, so I guess I should add:
#
# Copyright (c) 2003 bioperl, Rob Edwards. All Rights Reserved.
#           This module is free software; you can redistribute it and/or
#           modify it under the same terms as Perl itself. 
#
# Copyright Rob Edwards
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Primer3 - Create input for and work with the output 
from the program primer3

=head1 SYNOPSIS

Bio::Tools::Primer3 creates the input files needed to design primers
using primer3 and provides mechanisms to access data in the primer3
output files.

This module provides a bioperl interface to the program primer3. See
http://frodo.wi.mit.edu/primer3/primer3_code.html for
details and to download the software. This module only works for
primer3 release 1 but is not guaranteed to work with earlier versions.

  # design some primers.
  # the output will be put into temp.out
  use Bio::Tools::Run::Primer3;
  use Bio::SeqIO;

  my $seqio = Bio::SeqIO->new(-file=>'data/dna1.fa');
  my $seq = $seqio->next_seq;
  my $primer3 = Bio::Tools::Run::Primer3->new(-seq => $seq,
                                              -outfile => "temp.out",
                                              -path => "/usr/bin/primer3_core");

  # or after the fact you can change the program_name
  $primer3->program_name('my_suprefast_primer3');

  unless ($primer3->executable) {
    print STDERR "primer3 can not be found. Is it installed?\n";
    exit(-1)
  }

  # what are the arguments, and what do they mean?
  my $args = $primer3->arguments;

  print "ARGUMENT\tMEANING\n";
  foreach my $key (keys %{$args}) {print "$key\t", $$args{$key}, "\n"}

  # set the maximum and minimum Tm of the primer
  $primer3->add_targets('PRIMER_MIN_TM'=>56, 'PRIMER_MAX_TM'=>90);

  # design the primers. This runs primer3 and returns a 
  # Bio::Tools::Run::Primer3 object with the results
  $results = $primer3->run;

  # see the Bio::Tools::Run::Primer3 pod for
  # things that you can get from this. For example:

  print "There were ", $results->number_of_results, " primers\n";

Bio::Tools::Run::Primer3 creates the input files needed to design primers
using primer3 and provides mechanisms to access data in the primer3
output files.

This module provides a bioperl interface to the program primer3. See
http://www-genome.wi.mit.edu/genome_software/other/primer3.html for
details and to download the software.

This module is based on one written by Chad Matsalla
(bioinformatics1@dieselwurks.com). I have ripped some of his code, and 
added a lot of my own. I hope he is not mad at me!

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://www.bioperl.org/MailList.html             - About the mailing lists

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

=head1 AUTHOR

Rob Edwards

redwards@utmem.edu

Based heavily on work of Chad Matsalla

bioinformatics1@dieselwurks.com

=head1 CONTRIBUTORS

Shawn Hoon shawnh-at-stanford.edu
Jason Stajich jason-at-bioperl.org
Brian Osborne osborne1-at-optonline.net

=head1 SEE ALSO

L<Bio::Tools::Primer3>

=head1 APPENDIX

The rest of the documentation details each of the object methods. 
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::Primer3;

use vars qw(@ISA);
use strict;
use Bio::Root::Root;
use Bio::Tools::Primer3;
use Bio::Tools::Run::WrapperBase;
use File::Spec;

use vars qw($AUTOLOAD @ISA @PRIMER3_PARAMS $PROGRAMNAME %OK_FIELD);

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);


BEGIN { 
	$PROGRAMNAME = 'primer3';
	@PRIMER3_PARAMS=qw( PROGRAM EXCLUDED_REGION INCLUDED_REGION
 PRIMER_COMMENT PRIMER_DNA_CONC PRIMER_EXPLAIN_FLAG PRIMER_FILE_FLAG
 PRIMER_FIRST_BASE_INDEX PRIMER_GC_CLAMP
 PRIMER_INTERNAL_OLIGO_DNA_CONC PRIMER_INTERNAL_OLIGO_EXCLUDED_REGION
 PRIMER_INTERNAL_OLIGO_INPUT PRIMER_INTERNAL_OLIGO_MAX_GC
 PRIMER_INTERNAL_OLIGO_MAX_MISHYB PRIMER_INTERNAL_OLIGO_MAX_POLY_X
 PRIMER_INTERNAL_OLIGO_MAX_SIZE PRIMER_INTERNAL_OLIGO_MAX_TM
 PRIMER_INTERNAL_OLIGO_MIN_GC PRIMER_INTERNAL_OLIGO_MIN_QUALITY
 PRIMER_INTERNAL_OLIGO_MIN_SIZE PRIMER_INTERNAL_OLIGO_MIN_TM
 PRIMER_INTERNAL_OLIGO_MISHYB_LIBRARY
 PRIMER_INTERNAL_OLIGO_OPT_GC_PERCENT PRIMER_INTERNAL_OLIGO_OPT_SIZE
 PRIMER_INTERNAL_OLIGO_OPT_TM PRIMER_INTERNAL_OLIGO_SALT_CONC
 PRIMER_INTERNAL_OLIGO_SELF_ANY PRIMER_INTERNAL_OLIGO_SELF_END
 PRIMER_IO_WT_COMPL_ANY PRIMER_IO_WT_COMPL_END PRIMER_IO_WT_END_QUAL
 PRIMER_IO_WT_GC_PERCENT_GT PRIMER_IO_WT_GC_PERCENT_LT
 PRIMER_IO_WT_NUM_NS PRIMER_IO_WT_REP_SIM PRIMER_IO_WT_SEQ_QUAL
 PRIMER_IO_WT_SIZE_GT PRIMER_IO_WT_SIZE_LT PRIMER_IO_WT_TM_GT
 PRIMER_IO_WT_TM_LT PRIMER_LEFT_INPUT PRIMER_LIBERAL_BASE
 PRIMER_MAX_DIFF_TM PRIMER_MAX_END_STABILITY PRIMER_MAX_GC
 PRIMER_MAX_MISPRIMING PRIMER_MAX_POLY_X PRIMER_MAX_SIZE PRIMER_MAX_TM
 PRIMER_MIN_END_QUALITY PRIMER_MIN_GC PRIMER_MIN_QUALITY
 PRIMER_MIN_SIZE PRIMER_MIN_TM PRIMER_MISPRIMING_LIBRARY
 PRIMER_NUM_NS_ACCEPTED PRIMER_NUM_RETURN PRIMER_OPT_GC_PERCENT
 PRIMER_OPT_SIZE PRIMER_OPT_TM PRIMER_PAIR_MAX_MISPRIMING
 PRIMER_PAIR_WT_COMPL_ANY PRIMER_PAIR_WT_COMPL_END
 PRIMER_PAIR_WT_DIFF_TM PRIMER_PAIR_WT_IO_PENALTY
 PRIMER_PAIR_WT_PRODUCT_SIZE_GT PRIMER_PAIR_WT_PRODUCT_SIZE_LT
 PRIMER_PAIR_WT_PRODUCT_TM_GT PRIMER_PAIR_WT_PRODUCT_TM_LT
 PRIMER_PAIR_WT_PR_PENALTY PRIMER_PAIR_WT_REP_SIM PRIMER_PICK_ANYWAY
 PRIMER_PICK_INTERNAL_OLIGO PRIMER_PRODUCT_MAX_TM
 PRIMER_PRODUCT_MIN_TM PRIMER_PRODUCT_OPT_SIZE PRIMER_PRODUCT_OPT_TM
 PRIMER_PRODUCT_SIZE_RANGE PRIMER_QUALITY_RANGE_MAX
 PRIMER_QUALITY_RANGE_MIN PRIMER_RIGHT_INPUT PRIMER_SALT_CONC
 PRIMER_SELF_ANY PRIMER_SELF_END PRIMER_SEQUENCE_ID
 PRIMER_SEQUENCE_QUALITY PRIMER_START_CODON_POSITION PRIMER_TASK
 PRIMER_WT_COMPL_ANY PRIMER_WT_COMPL_END PRIMER_WT_END_QUAL
 PRIMER_WT_END_STABILITY PRIMER_WT_GC_PERCENT_GT
 PRIMER_WT_GC_PERCENT_LT PRIMER_WT_NUM_NS PRIMER_WT_POS_PENALTY
 PRIMER_WT_REP_SIM PRIMER_WT_SEQ_QUAL PRIMER_WT_SIZE_GT
 PRIMER_WT_SIZE_LT PRIMER_WT_TM_GT PRIMER_WT_TM_LT SEQUENCE TARGET 
 PRIMER_DEFAULT_PRODUCT
 PRIMER_DEFAULT_SIZE
 PRIMER_INSIDE_PENALTY
 PRIMER_INTERNAL_OLIGO_MAX_TEMPLATE_MISHYB
 PRIMER_OUTSIDE_PENALTY
 PRIMER_LIB_AMBIGUITY_CODES_CONSENSUS
 PRIMER_MAX_TEMPLATE_MISPRIMING
 PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING
 PRIMER_PAIR_WT_TEMPLATE_MISPRIMING
 PRIMER_WT_TEMPLATE_MISPRIMING
);

	foreach my $attr (@PRIMER3_PARAMS) {$OK_FIELD{$attr}++}
}

sub AUTOLOAD {
	my $self = shift;
	my $attr = $AUTOLOAD;
	$attr =~ s/.*:://;
	$attr = uc $attr;
	$self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
	$self->{$attr} = shift if @_;
	return $self->{$attr};
}


=head2 new()

 Title   : new()
 Usage   : my $primer3 = Bio::Tools::Run::Primer3->new(-file=>$file) to read 
           a primer3 output file.
           my $primer3 = Bio::Tools::Run::Primer3->new(-seq=>sequence object) 
           design primers against sequence
 Function: Start primer3 working and adds a sequence. At the moment it 
           will not clear out the old sequence, but I suppose it should.
 Returns : Does not return anything. If called with a filename will allow 
           you to retrieve the results
 Args    : -seq (optional) Bio::Seq object of sequence. This is required 
           to run primer3 but can be added later with add_targets()
	        -outfile file name to output results to (can also be added 
           with $primer3->outfile_name
	        -path path to primer3 executable, including program name, e.g. 
           "/usr/bin/primer3_core". This can also be set with program_name 
           and program_dir
	        -verbose (optional) set verbose output
 Notes   :

=cut


sub new {
	my($class,%args) = @_;
	my $self = $class->SUPER::new(%args);
	$self->io->_initialize_io();

	$self->program_name($args{-program}) if defined $args{'-program'};

	if ($args{'-verbose'}) {$self->{'verbose'}=1}
	if ($args{'-seq'}) {
		$self->{'seqobject'}=$args{'-seq'};
		my @input;
		push (@input, ("PRIMER_SEQUENCE_ID=".$self->{'seqobject'}->id),
				("SEQUENCE=".$self->{'seqobject'}->seq));
		$self->{'primer3_input'}=\@input;
	}
	if ($args{'-outfile'}) {$self->{_outfilename}=$args{'-outfile'}}
	if ($args{'-path'}) {
	  
		my (undef,$path,$prog) = File::Spec->splitpath($args{'-path'});
	  
    # For Windows system, $path better (Letter disk not truncated)
    if ( $^O =~ m{mswin}i ) {
      require File::Basename;
      $path = File::Basename::dirname( $args{'-path'} );
      $prog = File::Basename::basename( $args{'-path'} );
    }
    
		$self->program_dir($path);
		$self->program_name($prog);
	}
	return $self;
}

=head2 program_name

 Title   : program_name
 Usage   : $primer3->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
	my $self = shift;
	return $self->{'program_name'} = shift @_ if @_;
    return $self->{'program_name'} if $self->{'program_name'};
    for (qw(primer3 primer3_core)) {
        if ($self->io->exists_exe($_)) {
            $PROGRAMNAME = $_;
            last;
        }
    }
    # don't set permanently, use global
    return $PROGRAMNAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $primer3->program_dir($dir)
 Function: returns the program directory, which may also be obtained from ENV variable.
 Returns :  string
 Args    :

=cut

sub program_dir {
   my ($self, $dir) = @_;
   if ($dir) {
      $self->{'program_dir'}=$dir;
   } 
   
   # we need to stop here if we know what the answer is, otherwise we can 
   # never set it and then call it later
   return $self->{'program_dir'} if $self->{'program_dir'};
   
   if ($ENV{PRIMER3}) {
        $self->{'program_dir'} = Bio::Root::IO->catfile($ENV{PRIMER3});
   } else {
        $self->{'program_dir'} = Bio::Root::IO->catfile('usr','local','bin');
   }
   
   return $self->{'program_dir'}
}


=head2 add_targets()

 Title   : add_targets()
 Usage   : $primer3->add_targets(key=>value)
 Function: Add any legal value to the input command line. 
 Returns : Returns the number of arguments added.
 Args    : Use $primer3->arguments to find a list of all the values 
           that are allowed, or see the primer3 docs.
 Notes   : This will only do limited error checking at the moment, 
           but it should work.

=cut


sub add_targets {
	my ($self, %args)=@_;
	my $added_args; # a count of what we have added.
	my $inputarray = $self->{'primer3_input'};
	foreach my $key (keys %args) {
		# we will allow them to add a sequence before checking for arguments
		if ((uc($key) eq "-SEQ") || (uc($key) eq "-SEQUENCE")) {
			# adding a new sequence. We need to separate them with an =
			$self->{'seqobject'}=$args{$key};
			if (defined $$inputarray[0]) {push (@$inputarray, "=")}
			push (@$inputarray, ("PRIMER_SEQUENCE_ID=".
			  $self->{'seqobject'}->id),("SEQUENCE=".$self->{'seqobject'}->seq));
			next;
		}

		unless ($self->{'no_param_checks'}) {
			unless ($OK_FIELD{$key}) {
				$self->warn("Parameter $key is not a valid Primer3 parameter"); 
				next}
		}

		if (uc($key) eq "INCLUDED_REGION") {
			# this must be a comma separated start, length.
			my $sequencelength;
			# we don't have a length, hence we need to add the length of the 
			# sequence less the start.
			foreach my $input (@$inputarray) {
				if ($input =~ /SEQUENCE=(.*)/) {$sequencelength=length($1)}
			}
		
		        if (!$args{$key}) {$args{$key}="0," . $sequencelength}
			elsif ($args{$key} !~ /\,/) {
				my $length_of_included = $sequencelength-$args{$key};
				$args{$key} .= ",".$length_of_included;
			}
		}
		elsif (uc($key) eq "PRIMER_MIN_SIZE") {
			# minimum size must be less than MAX size and greater than zero
			if (exists $args{"PRIMER_MAX_SIZE"}) {
				unless ($args{"PRIMER_MAX_SIZE"} > $args{"PRIMER_MIN_SIZE"}) {
					$self->warn('Maximum primer size (PRIMER_MAX_SIZE) must be greater than minimum primer size (PRIMER_MIN_SIZE)');
				}
			}
			if ($args{$key} < 0) {
				$self->warn('Minimum primer size (PRIMER_MIN_SIZE) must be greater than 0');
			}
		}
		elsif ($key eq "PRIMER_MAX_SIZE") {
			if ($args{$key}>35) {$self->warn('Maximum primer size (PRIMER_MAX_SIZE) must be less than 35')}
		}
		elsif (uc($key) eq "SEQUENCE") {
		    # Add seqobject if not present, since it is checked for by Bio::Tools::Primer3->next_primer()
		    $self->{'seqobject'}=Bio::Seq->new(-seq=>$args{$key}) if not defined($self->{'seqobject'});
		}

		# need a check to see whether this is already in the array
		# and finally add the argument to the list.

		my $toadd=uc($key)."=".$args{$key}; 
		my $replaced; # don't add it if it is replacing something!
		my @new_array;
		foreach my $input (@$inputarray) {
			my ($array_key, $array_value) = split '=', $input;
			if (uc($array_key) eq uc($key)) {push @new_array, $toadd; $replaced=1}
			else {push @new_array, $input}
		}
		unless ($replaced) {push @new_array, $toadd}
		@$inputarray=@new_array;

		if ($self->{'verbose'}) {print STDERR "Updated ",
											uc($key), " to $args{$key}\n"}
		$added_args++;
	}

	$self->{'primer3_input'}=$inputarray;
	return $added_args;
}

=head2 run()

 Title   : run()
 Usage   : $primer3->run();
 Function: Run the primer3 program with the arguments that you have supplied.
 Returns : A Bio::Tools::Primer3 object containing the results.
 Args    : None.
 Note    : See the Bio::Tools::Primer3 documentation for those functions.

=cut

sub run {
	my($self) = @_;
	my $executable = $self->executable;
	my $input = $self->{'primer3_input'};
	unless ($executable && -e $executable) {
		$self->throw("Executable was not found. Do not know where primer3 is!") if !$executable;
		$self->throw("$executable was not found. Do not know where primer3 is!");
		exit(-1);
	}

	# note that I write this to a temp file because we need both read 
	# and write access to primer3, therefore,
	# we can't use a simple pipe.

	if ($self->{'verbose'}) {print STDERR "TRYING\n", 
				 join "\n", @{$self->{'primer3_input'}}, "=\n"}

	# make a temporary file and print the instructions to it.
	my ($temphandle, $tempfile) = $self->io->tempfile;
	print $temphandle join "\n", @{$self->{'primer3_input'}}, "=\n";
	close($temphandle);

  my $executable_command = $executable;
  if ( $executable =~ m{^[^\'\"]+(.+)[^\'\"]+$} ) { 
    $executable_command = "\"$executable\" < \"$tempfile\"|";
  }

	open (RESULTS, $executable_command) || $self->throw("Can't open RESULTS");
	if ($self->{'_outfilename'}) {
		# I can't figure out how to use either of these to write the results out.
		# neither work, what am I doing wrong or missing in the docs?
		#  $self->{output}=$self->_initialize_io(-file=>$self->{'outfile'});
		#  $self->{output}=$self->io;
		# OK, for now, I will just do it myself, because I need this to 
		# check the parser :)
		open (OUT, ">".$self->{'_outfilename'}) || 
		  $self->throw("Can't open ".$self->{'_outfilename'}." for writing");
	}

	my @results;
	while (<RESULTS>) {
	    if ($self->{'_outfilename'}) {
		# this should work, but isn't
		#$self->{output}->_print($_);
		print OUT $_;
	    }
	    chomp;
	    next if( $_ eq '='); # skip over bolderio record terminator
	    my ($return, $value) = split('=',$_);
	    $self->{'results'}->{$return} = $value;
	}
	close RESULTS;

	# close the output file
	if ($self->{'_outfilename'}) { 
		close OUT;
	}

	$self->cleanup;
	# convert the results to individual results
	$self->{results_obj} = Bio::Tools::Primer3->new;
	$self->{results_obj}->_set_variable('results', $self->{results});
	$self->{results_obj}->_set_variable('seqobject', $self->{seqobject});

        # Bio::Tools::Primer3::_separate needs a hash of the primer3 arguments,
 	# with the arg as the key and the value as the value (surprise!).
 	my %input_hash = map {split '='} @{$self->{'primer3_input'}};
 	$self->{results_obj}->_set_variable('input_options', \%input_hash);
	$self->{results_separated}= $self->{results_obj}->_separate();
	return $self->{results_obj};
}

=head2 arguments()

 Title   : arguments()
 Usage   : $hashref = $primer3->arguments();
 Function: Describes the options that you can set through Bio::Tools::Run::Primer3, 
           with a brief (one line) description of what they are and their 
           default values
 Returns : A string (if an argument is supplied) or a reference to a hash.
 Args    : If supplied with an argument will return a string of its 
           description.
           If no arguments are supplied, will return all the arguments as a 
           reference to a hash
 Notes   : Much of this is taken from the primer3 README file, and you should 
           read that file for a more detailed description.

=cut

sub arguments {
	my ($self, $required) = @_;
	unless ($self->{'input_options'}) {$self->_input_args}
	if ($required) {return ${$self->{'input_options'}}{'$required'}}
	else {return $self->{'input_options'}}
}

=head2  version

 Title   : version
 Usage   : $v = $prog->version();
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    return unless my $exe = $self->executable;
    if (!defined $self->{'_progversion'}) {
        my $string = `$exe -about 2>&1`;
        my $v;
        if ($string =~ m{primer3\s+release\s+([\d\.]+)}) {
            $self->{'_progversion'} = $1;
        }
    }
    return $self->{'_progversion'} || undef;
}

=head2 _input_args()

 Title   : _input_args()
 Usage   : an internal method to set the input arguments for Primer3
 Function: Define a hash with keys for each of the input arguments and values 
           as a short one line description
 Returns : A reference to a hash.
 Args    : None.
 Notes   : Much of this is taken from the primer3 README file, and you should 
           read that file for a more detailed description.

=cut

sub _input_args {
	my($self) = shift;
	# just return functions that we can set and what they are 
	my %hash=(
	'PRIMER_SEQUENCE_ID'=>'(string, optional) an id. Optional. Note must be present if PRIMER_FILE_FLAG is set',
  'SEQUENCE'=>'(nucleotide sequence, REQUIRED) The sequence itself. Cannot contain newlines',
  'INCLUDED_REGION'=>'(interval, optional) Where to pick primers from. In form <start>,<length>. Based on zero indexing!',
  'TARGET'=>'(interval list, default empty) Regions that must be included in the product. The value should be a space-separated list of <start>,<length>',
  'EXCLUDED_REGION'=>'(interval list, default empty) Regions that must NOT be included in the product. The value should be a space-separated list of <start>,<length>',
  'PRIMER_COMMENT'=>'(string) This is ignored, so we will just save, and return it',
  'PRIMER_SEQUENCE_QUALITY'=>'(quality list, default empty) A list of space separated integers with one per base. Could adapt a Phred object to this.',
  'PRIMER_LEFT_INPUT'=>'(nucleotide sequence, default empty) If you know the left primer sequence, put it here',
  'PRIMER_RIGHT_INPUT'=>'(nucleotide sequence, default empty) If you know the right primer sequence, put it here',
  'PRIMER_START_CODON_POSITION'=>'(int, default -1000000) Location of known start codons for designing in frame primers.',
  'PRIMER_PICK_ANYWAY'=>'boolean, default 0) Pick a primer, even if we have violated some constraints.',
  'PRIMER_MISPRIMING_LIBRARY'=>'(string, optional) A file containing sequences to avoid amplifying. Should be fasta format, but see primer3 docs for constraints.',
  'PRIMER_MAX_MISPRIMING'=>'(decimal,9999.99, default 12.00) Weighting for PRIMER_MISPRIMING_LIBRARY',
  'PRIMER_PAIR_MAX_MISPRIMING'=>'(decimal,9999.99, default 24.00 Weighting for PRIMER_MISPRIMING_LIBRARY',
  'PRIMER_PRODUCT_MAX_TM'=>'(float, default 1000000.0) The maximum allowed Tm of the product.',
  'PRIMER_PRODUCT_MIN_TM'=>'(float, default -1000000.0) The minimum allowed Tm of the product',
  'PRIMER_EXPLAIN_FLAG'=>'(boolean, default 0) If set it will print a bunch of information out.',
  'PRIMER_PRODUCT_SIZE_RANGE'=>'(size range list, default 100-300) space separated list of product sizes eg <a>-<b> <x>-<y>',
  
  'PRIMER_DEFAULT_PRODUCT' => '(size range list, default 100-300)',
  'PRIMER_PICK_INTERNAL_OLIGO'=>'(boolean, default 0) if set, a hybridization probe will be selected',
  'PRIMER_GC_CLAMP'=>'(int, default 0) Number of Gs and Cs at the 3 prime end.',
  'PRIMER_OPT_SIZE'=>'(int, default 20) Optimal primer size. Primers will be close to this value in length',
  'PRIMER_DEFAULT_SIZE' => '(int, default 20)',
  'PRIMER_MIN_SIZE'=>'(int, default 18) Minimum size. Must be 0 < PRIMER_MIN_SIZE < PRIMER_MAX_SIZE ',
  'PRIMER_MAX_SIZE'=>'(int, default 27) Maximum size. Must be < 35.',
  'PRIMER_OPT_TM'=>'(float, default 60.0C) Optimum Tm of a primer.',
  'PRIMER_MIN_TM'=>'(float, default 57.0C) Minimum Tm of a primer',
  'PRIMER_MAX_TM'=>'(float, default 63.0C) Maximum Tm of a primer',
  'PRIMER_MAX_DIFF_TM'=>'(float, default 100.0C) acceptable difference in Tms',
  'PRIMER_MIN_GC'=>'(float, default 20.0%) Minimum allowable GCs',
  'PRIMER_OPT_GC_PERCENT'=>'(float, default 50.0%) Optimal GCs',
  'PRIMER_MAX_GC'=>'(float, default 80.0%) Maximum allowable GCs',
  'PRIMER_SALT_CONC'=>'(float, default 50.0 mM) Salt concentration required for Tm calcs.',
  'PRIMER_DNA_CONC'=>'(float, default 50.0 nM) DNA concentration required for Tm calcs. ',
  'PRIMER_NUM_NS_ACCEPTED'=>'(int, default 0) Maximum number of unknown bases (N) allowable in any primer.',
  'PRIMER_SELF_ANY'=>'(decimal,9999.99, default 8.00) Maximum aligment score for within and between primers when checking for hairpin loops',
  'PRIMER_SELF_END'=>'(decimal 9999.99, default 3.00) Maximum aligment score for within and between primers when checking for primer dimers',
  'PRIMER_FILE_FLAG'=>'(boolean, default 0) Output <sequence_id>.for and <sequence_id>.rev with all acceptable forward and reverse primers',
  'PRIMER_MAX_POLY_X'=>'(int, default 5) The maximum allowable length of a mononucleotide repeat.',
  'PRIMER_LIBERAL_BASE'=>'(boolean, default 0) Use IUPAC codes (well, just change them to N). Note must also set PRIMER_NUM_NS_ACCEPTED',
  'PRIMER_NUM_RETURN'=>'(int, default 5) Number of primers to return',
  'PRIMER_FIRST_BASE_INDEX'=>'(int, default 0) Index of the first base. Do not change this or allow it to be changed, as we will have to mess with subseqs and whatnot.',
  'PRIMER_MIN_QUALITY'=>'(int, default 0) Minimum sequence quality calculated from PRIMER_SEQUENCE_QUALITY',
  'PRIMER_MIN_END_QUALITY'=>'(int, default 0) Minimum sequence quality calculated from PRIMER_SEQUENCE_QUALITY at 5 prime 5 bases',
  'PRIMER_QUALITY_RANGE_MIN'=>'(int, default 0) Minimum sequence quality calculated from PRIMER_SEQUENCE_QUALITY',
  'PRIMER_QUALITY_RANGE_MAX'=>'(int, default 100) Maximum sequence quality calculated from PRIMER_SEQUENCE_QUALITY',
  'PRIMER_MAX_END_STABILITY'=>'(float 999.9999, default 100.0) Maximum stability for the five 3 prime bases of a primer. Bigger numbers mean more stable 3 prime ends.',
  'PRIMER_PRODUCT_OPT_TM'=>'(float, default 0.0) Optimum melting temperature for the PCR product. 0 means no optimum.',
  'PRIMER_PRODUCT_OPT_SIZE'=>'(int, default 0) Optimum size for the PCR product. 0 means no optimum.',
  'PRIMER_TASK'=>'(string, default pick_pcr_primers) Choose from pick_pcr_primers, pick_pcr_primers_and_hyb_probe, pick_left_only, pick_right_only, pick_hyb_probe_only',
  'PRIMER_WT_TM_GT'=>'(float, default 1.0) Penalty weight for primers with Tm over PRIMER_OPT_TM.',
  'PRIMER_WT_TM_LT'=>'(float, default 1.0) Penalty weight for primers with Tm under PRIMER_OPT_TM.',
  'PRIMER_WT_SIZE_LT'=>'(float, default 1.0) Penalty weight for primers shorter than PRIMER_OPT_SIZE.',
  'PRIMER_WT_SIZE_GT'=>'(float, default 1.0) Penalty weight for primers longer than PRIMER_OPT_SIZE.',
  'PRIMER_WT_GC_PERCENT_LT'=>'(float, default 1.0) Penalty weight for primers with GC percent greater than PRIMER_OPT_GC_PERCENT.',
  'PRIMER_WT_GC_PERCENT_GT'=>'(float, default 1.0) Penalty weight for primers with GC percent greater than PRIMER_OPT_GC_PERCENT.',
  'PRIMER_WT_COMPL_ANY'=>'(float, default 0.0)',
  'PRIMER_WT_COMPL_END'=>'(float, default 0.0)',
  'PRIMER_WT_NUM_NS'=>'(float, default 0.0)',
  'PRIMER_WT_REP_SIM'=>'(float, default 0.0)',
  'PRIMER_WT_SEQ_QUAL'=>'(float, default 0.0)',
  'PRIMER_WT_END_QUAL'=>'(float, default 0.0)',
  'PRIMER_WT_POS_PENALTY'=>'(float, default 0.0)',
  'PRIMER_WT_END_STABILITY'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_PR_PENALTY'=>'(float, default 1.0)',
  'PRIMER_PAIR_WT_IO_PENALTY'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_DIFF_TM'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_COMPL_ANY'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_COMPL_END'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_PRODUCT_TM_LT'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_PRODUCT_TM_GT'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_PRODUCT_SIZE_GT'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_PRODUCT_SIZE_LT'=>'(float, default 0.0)',
  'PRIMER_PAIR_WT_REP_SIM'=>'(float, default 0.0)',
  'PRIMER_INTERNAL_OLIGO_EXCLUDED_REGION'=>'(interval list, default empty) Internal oligos must ignore these regions',
  'PRIMER_INTERNAL_OLIGO_INPUT'=>'(nucleotide sequence, default empty) Known sequence of an internal oligo',
  'PRIMER_INTERNAL_OLIGO_OPT_SIZE'=>'(int, default 20)',
  'PRIMER_INTERNAL_OLIGO_MIN_SIZE'=>'(int, default 18)',
  'PRIMER_INTERNAL_OLIGO_MAX_SIZE'=>'(int, default 27)',
  'PRIMER_INTERNAL_OLIGO_OPT_TM'=>'(float, default 60.0 degrees C)',
  'PRIMER_INTERNAL_OLIGO_OPT_GC_PERCENT'=>'(float, default 50.0%)',
  'PRIMER_INTERNAL_OLIGO_MIN_TM'=>'(float, default 57.0 degrees C)',
  'PRIMER_INTERNAL_OLIGO_MAX_TM'=>'(float, default 63.0 degrees C)',
  'PRIMER_INTERNAL_OLIGO_MIN_GC'=>'(float, default 20.0%)',
  'PRIMER_INTERNAL_OLIGO_MAX_GC'=>'(float, default 80.0%)',
  'PRIMER_INTERNAL_OLIGO_SALT_CONC'=>'(float, default 50.0 mM)',
  'PRIMER_INTERNAL_OLIGO_DNA_CONC'=>'(float, default 50.0 nM)',
  'PRIMER_INTERNAL_OLIGO_SELF_ANY'=>'(decimal 9999.99, default 12.00)',
  'PRIMER_INTERNAL_OLIGO_MAX_POLY_X'=>'(int, default 5)',
  'PRIMER_INTERNAL_OLIGO_SELF_END'=>'(decimal 9999.99, default 12.00)',
  'PRIMER_INTERNAL_OLIGO_MISHYB_LIBRARY'=>'(string, optional)',
  'PRIMER_INTERNAL_OLIGO_MAX_MISHYB'=>'(decimal,9999.99, default 12.00)',
  'PRIMER_INTERNAL_OLIGO_MIN_QUALITY'=>'(int, default 0)',
  'PRIMER_IO_WT_TM_GT'=>'(float, default 1.0)',
  'PRIMER_IO_WT_TM_LT'=>'(float, default 1.0)',
  'PRIMER_IO_WT_GC_PERCENT_GT'=>'(float, default 1.0)',
  'PRIMER_IO_WT_GC_PERCENT_LT'=>'(float, default 1.0)',
  'PRIMER_IO_WT_SIZE_LT'=>'(float, default 1.0)',
  'PRIMER_IO_WT_SIZE_GT'=>'(float, default 1.0)',
  'PRIMER_IO_WT_COMPL_ANY'=>'(float, default 0.0)',
  'PRIMER_IO_WT_COMPL_END'=>'(float, default 0.0)',
  'PRIMER_IO_WT_NUM_NS'=>'(float, default 0.0)',
  'PRIMER_IO_WT_REP_SIM'=>'(float, default 0.0)',
  'PRIMER_IO_WT_SEQ_QUAL'=>'(float, default 0.0)',
  'PRIMER_IO_WT_END_QUAL'=>'(float, default 0.0)',
  'PRIMER_INSIDE_PENALTY' =>  '(float, default -1.0)',
  'PRIMER_INTERNAL_OLIGO_MAX_TEMPLATE_MISHYB' => '(decimal 9999.99, default 12.00)',
  'PRIMER_OUTSIDE_PENALTY' => '(float, default 0.0)',
  'PRIMER_LIB_AMBIGUITY_CODES_CONSENSUS' => '(boolean, default 1)',
  'PRIMER_MAX_TEMPLATE_MISPRIMING' => '(decimal,9999.99, default -1.00)',
  'PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING' => '(decimal,9999.99, default -1.00)',
  'PRIMER_PAIR_WT_TEMPLATE_MISPRIMING' => '(float, default 0.0)',
  'PRIMER_WT_TEMPLATE_MISPRIMING' => '(float, default 0.0)'
);
 $self->{'input_options'}=\%hash;
 return \%hash;
}

1;
