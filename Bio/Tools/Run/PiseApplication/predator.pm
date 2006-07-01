# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::predator
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::predator

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::predator

      Bioperl class for:

	PREDATOR	Protein secondary structure prediction from a single sequence or a set of sequences (D. Frishman & P. Argos)

	References:

		Frishman, D. and Argos, P. (1996) Incorporation  of  long-distance interactions  into  a  secondary structure prediction algorithm. Protein Engineering,  9, 133-142.

		Frishman,  D. and Argos,  P.  (1997)  75%  accuracy  in  protein secondary structure prediction.  Proteins,  27, 329-335.

		Frishman,D and Argos,P. (1995) Knowledge-based secondary structure assignment. Proteins:  structure,  function  and genetics, 23, 566-579.

		Kabsch,W. and Sander,C. (1983)  Dictionary  of  protein  secondary structure: pattern    recognition   of hydrogen-bonded and geometrical features. Biopolymers, 22: 2577-2637.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/predator.html 
         for available values):


		predator (String)

		seq (Sequence)
			Protein sequence(s) File
			pipe: seqsfile

		single (Switch)
			Perform  single  sequence  prediction. Ignore  other sequences in the set for computing the prediction (-s)

		dont_copy (Switch)
			Do not copy assignment directly from the PDB database (-u)

		dssp (Switch)
			Use DSSP target assignment (-d)

		percentid (Float)
			Find a subset of sequences with no more than this identity between any pair of sequences (-n)

		all (Switch)
			Make prediction for All sequences in the input file (-a)

		seqid (String)
			Make prediction for this sequence (give its id) (-i)

		stride_file (InFile)
			STRIDE file (-x)
			pipe: stride_outfile

		dssp_file (InFile)
			DSSP file (-y)
			pipe: dssp_outfile

		pdb_chain (String)
			PDB Chain (-z)

		long (Switch)
			Long output form (-l)

		other_info (Switch)
			Output  other  additional information if available (-h)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://bioweb.pasteur.fr/seqanal/interfaces/predator.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::predator;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $predator = Bio::Tools::Run::PiseApplication::predator->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::predator object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $predator = $factory->program('predator');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::predator.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/predator.pm

    $self->{COMMAND}   = "predator";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PREDATOR";

    $self->{DESCRIPTION}   = "Protein secondary structure prediction from a single sequence or a set of sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "D. Frishman & P. Argos";

    $self->{REFERENCE}   = [

         "Frishman, D. and Argos, P. (1996) Incorporation  of  long-distance interactions  into  a  secondary structure prediction algorithm. Protein Engineering,  9, 133-142.",

         "Frishman,  D. and Argos,  P.  (1997)  75%  accuracy  in  protein secondary structure prediction.  Proteins,  27, 329-335.",

         "Frishman,D and Argos,P. (1995) Knowledge-based secondary structure assignment. Proteins:  structure,  function  and genetics, 23, 566-579.",

         "Kabsch,W. and Sander,C. (1983)  Dictionary  of  protein  secondary structure: pattern    recognition   of hydrogen-bonded and geometrical features. Biopolymers, 22: 2577-2637.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"predator",
	"seq",
	"prediction",
	"input",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"predator",
	"seq", 	# Protein sequence(s) File
	"prediction", 	# Prediction options
	"single", 	# Perform  single  sequence  prediction. Ignore  other sequences in the set for computing the prediction (-s)
	"dont_copy", 	# Do not copy assignment directly from the PDB database (-u)
	"dssp", 	# Use DSSP target assignment (-d)
	"percentid", 	# Find a subset of sequences with no more than this identity between any pair of sequences (-n)
	"input", 	# Input parameters
	"all", 	# Make prediction for All sequences in the input file (-a)
	"seqid", 	# Make prediction for this sequence (give its id) (-i)
	"stride_file", 	# STRIDE file (-x)
	"dssp_file", 	# DSSP file (-y)
	"pdb_chain", 	# PDB Chain (-z)
	"output", 	# Output parameters
	"long", 	# Long output form (-l)
	"other_info", 	# Output  other  additional information if available (-h)

    ];

    $self->{TYPE}  = {
	"predator" => 'String',
	"seq" => 'Sequence',
	"prediction" => 'Paragraph',
	"single" => 'Switch',
	"dont_copy" => 'Switch',
	"dssp" => 'Switch',
	"percentid" => 'Float',
	"input" => 'Paragraph',
	"all" => 'Switch',
	"seqid" => 'String',
	"stride_file" => 'InFile',
	"dssp_file" => 'InFile',
	"pdb_chain" => 'String',
	"output" => 'Paragraph',
	"long" => 'Switch',
	"other_info" => 'Switch',

    };

    $self->{FORMAT}  = {
	"predator" => {
		"perl" => '"predator"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"prediction" => {
	},
	"single" => {
		"perl" => ' ($value)? " -s" : "" ',
	},
	"dont_copy" => {
		"perl" => ' ($value)? " -u" : "" ',
	},
	"dssp" => {
		"perl" => ' ($value)? " -d" : "" ',
	},
	"percentid" => {
		"perl" => ' (defined $value)? " -n$value" : "" ',
	},
	"input" => {
	},
	"all" => {
		"perl" => ' ($value)? " -a" : "" ',
	},
	"seqid" => {
		"perl" => ' ($value)? " -i$value" : "" ',
	},
	"stride_file" => {
		"perl" => ' ($value)? " -x$value" : "" ',
	},
	"dssp_file" => {
		"perl" => ' ($value)? " -y$value" : "" ',
	},
	"pdb_chain" => {
		"perl" => ' ($value)? " -z$value" : " -z-" ',
	},
	"output" => {
	},
	"long" => {
		"perl" => ' ($value)? " -l" : "" ',
	},
	"other_info" => {
		"perl" => ' ($value)? " -h" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [8,100,15],

    };

    $self->{GROUP}  = {
	"predator" => 0,
	"seq" => 100,
	"prediction" => 1,
	"single" => 1,
	"dont_copy" => 1,
	"dssp" => 1,
	"percentid" => 1,
	"input" => 1,
	"all" => 1,
	"seqid" => 1,
	"stride_file" => 1,
	"dssp_file" => 1,
	"pdb_chain" => 1,
	"output" => 1,
	"long" => 1,
	"other_info" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"predator",
	"other_info",
	"prediction",
	"single",
	"dont_copy",
	"dssp",
	"percentid",
	"input",
	"all",
	"seqid",
	"stride_file",
	"dssp_file",
	"pdb_chain",
	"output",
	"long",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"predator" => 1,
	"seq" => 0,
	"prediction" => 0,
	"single" => 0,
	"dont_copy" => 0,
	"dssp" => 0,
	"percentid" => 0,
	"input" => 0,
	"all" => 0,
	"seqid" => 0,
	"stride_file" => 0,
	"dssp_file" => 0,
	"pdb_chain" => 0,
	"output" => 0,
	"long" => 0,
	"other_info" => 0,

    };

    $self->{ISCOMMAND}  = {
	"predator" => 1,
	"seq" => 0,
	"prediction" => 0,
	"single" => 0,
	"dont_copy" => 0,
	"dssp" => 0,
	"percentid" => 0,
	"input" => 0,
	"all" => 0,
	"seqid" => 0,
	"stride_file" => 0,
	"dssp_file" => 0,
	"pdb_chain" => 0,
	"output" => 0,
	"long" => 0,
	"other_info" => 0,

    };

    $self->{ISMANDATORY}  = {
	"predator" => 0,
	"seq" => 1,
	"prediction" => 0,
	"single" => 0,
	"dont_copy" => 0,
	"dssp" => 0,
	"percentid" => 0,
	"input" => 0,
	"all" => 0,
	"seqid" => 0,
	"stride_file" => 0,
	"dssp_file" => 0,
	"pdb_chain" => 0,
	"output" => 0,
	"long" => 0,
	"other_info" => 0,

    };

    $self->{PROMPT}  = {
	"predator" => "",
	"seq" => "Protein sequence(s) File",
	"prediction" => "Prediction options",
	"single" => "Perform  single  sequence  prediction. Ignore  other sequences in the set for computing the prediction (-s)",
	"dont_copy" => "Do not copy assignment directly from the PDB database (-u)",
	"dssp" => "Use DSSP target assignment (-d)",
	"percentid" => "Find a subset of sequences with no more than this identity between any pair of sequences (-n)",
	"input" => "Input parameters",
	"all" => "Make prediction for All sequences in the input file (-a)",
	"seqid" => "Make prediction for this sequence (give its id) (-i)",
	"stride_file" => "STRIDE file (-x)",
	"dssp_file" => "DSSP file (-y)",
	"pdb_chain" => "PDB Chain (-z)",
	"output" => "Output parameters",
	"long" => "Long output form (-l)",
	"other_info" => "Output  other  additional information if available (-h)",

    };

    $self->{ISSTANDOUT}  = {
	"predator" => 0,
	"seq" => 0,
	"prediction" => 0,
	"single" => 0,
	"dont_copy" => 0,
	"dssp" => 0,
	"percentid" => 0,
	"input" => 0,
	"all" => 0,
	"seqid" => 0,
	"stride_file" => 0,
	"dssp_file" => 0,
	"pdb_chain" => 0,
	"output" => 0,
	"long" => 0,
	"other_info" => 0,

    };

    $self->{VLIST}  = {

	"prediction" => ['single','dont_copy','dssp','percentid',],
	"input" => ['all','seqid','stride_file','dssp_file','pdb_chain',],
	"output" => ['long','other_info',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"single" => '0',
	"dont_copy" => '0',
	"dssp" => '0',
	"all" => '0',
	"long" => '0',
	"other_info" => '0',

    };

    $self->{PRECOND}  = {
	"predator" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"prediction" => { "perl" => '1' },
	"single" => {
		"perl" => '!$all',
	},
	"dont_copy" => { "perl" => '1' },
	"dssp" => {
		"perl" => '$dssp_file',
	},
	"percentid" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"all" => {
		"perl" => '!$seqid',
	},
	"seqid" => { "perl" => '1' },
	"stride_file" => { "perl" => '1' },
	"dssp_file" => { "perl" => '1' },
	"pdb_chain" => {
		"perl" => '$dssp_file || $stride_file ',
	},
	"output" => { "perl" => '1' },
	"long" => { "perl" => '1' },
	"other_info" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqsfile" => '1',
	},
	"stride_file" => {
		 "stride_outfile" => '1',
	},
	"dssp_file" => {
		 "dssp_outfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"predator" => 0,
	"seq" => 0,
	"prediction" => 0,
	"single" => 0,
	"dont_copy" => 0,
	"dssp" => 0,
	"percentid" => 0,
	"input" => 0,
	"all" => 0,
	"seqid" => 0,
	"stride_file" => 0,
	"dssp_file" => 0,
	"pdb_chain" => 0,
	"output" => 0,
	"long" => 0,
	"other_info" => 0,

    };

    $self->{ISSIMPLE}  = {
	"predator" => 1,
	"seq" => 1,
	"prediction" => 0,
	"single" => 0,
	"dont_copy" => 0,
	"dssp" => 0,
	"percentid" => 0,
	"input" => 0,
	"all" => 0,
	"seqid" => 0,
	"stride_file" => 0,
	"dssp_file" => 0,
	"pdb_chain" => 0,
	"output" => 0,
	"long" => 0,
	"other_info" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"dont_copy" => [
		"Do not copy assignment directly from the PDB database if query sequence is found in PDB. By default, the known conformation of 7-residue segments will be used if they are identical to a 7-residue fragment in the query sequence.",
	],
	"dssp" => [
		"Use DSSP target assignment (default is STRIDE). The predictions made with DSSP and STRIDE target assignments are optimized to reproduce these assignments as well as possible.",
	],
	"seqid" => [
		"This option is case sensitive!",
	],
	"long" => [
		"Every output line contains residue number, three-letter residue name, one-letter residue name, predicted secondary structural state and reliability estimate. If a STRIDE or DSSP secondary structure assignment has been read (see other options), the known assignment will also be shown in the output for comparison. By default the short output form is used.",
	],

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/predator.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

