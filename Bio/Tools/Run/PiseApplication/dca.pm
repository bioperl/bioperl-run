# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::dca
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::dca

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dca

      Bioperl class for:

	DCA	Divide-and-Conquer Multiple Sequence Alignment (J. Stoye)

	References:

		A.W.M. Dress, G. Füllen, S.W. Perrey, A Divide and Conquer Approach to Multiple Alignment, Proceedings of the Third International Conference on Intelligent Systems for Molecular Biology (ISMB 95), AAAI Press, Menlo Park, CA, USA, 107-113, 1995.

		J. Stoye, Multiple Sequence Alignment with the Divide-and-Conquer Method, Gene 211(2), GC45-GC56, 1998. (Gene-COMBIS)



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/dca.html 
         for available values):


		dca (String)

		seq (Sequence)
			Sequences File
			pipe: seqsfile

		cost (Excl)
			Cost matrix (default: depends on sequences) (-c)

		gaps (Switch)
			Penalize end gaps as internal gaps (default: free shift) (-g)

		approximate (Switch)
			Use approximate cut positions (-a)

		intensity (Float)
			Weight intensity (-b)

		recursion (Integer)
			Recursion stop size (-l)

		window (Integer)
			Window size (-w)

		quiet (Switch)

		output_format (Excl)
			Output format (-f)

		suppress_output (Switch)
			Suppress output about progress of the program (-o)

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

  http://bugzilla.open-bio.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/dca.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::dca;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dca = Bio::Tools::Run::PiseApplication::dca->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dca object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $dca = $factory->program('dca');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::dca.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dca.pm

    $self->{COMMAND}   = "dca";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DCA";

    $self->{DESCRIPTION}   = "Divide-and-Conquer Multiple Sequence Alignment";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{AUTHORS}   = "J. Stoye";

    $self->{REFERENCE}   = [

         "A.W.M. Dress, G. Füllen, S.W. Perrey, A Divide and Conquer Approach to Multiple Alignment, Proceedings of the Third International Conference on Intelligent Systems for Molecular Biology (ISMB 95), AAAI Press, Menlo Park, CA, USA, 107-113, 1995.",

         "J. Stoye, Multiple Sequence Alignment with the Divide-and-Conquer Method, Gene 211(2), GC45-GC56, 1998. (Gene-COMBIS)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dca",
	"seq",
	"outfile",
	"control",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dca",
	"seq", 	# Sequences File
	"outfile",
	"control", 	# Control parameters
	"cost", 	# Cost matrix (default: depends on sequences) (-c)
	"gaps", 	# Penalize end gaps as internal gaps (default: free shift) (-g)
	"approximate", 	# Use approximate cut positions (-a)
	"intensity", 	# Weight intensity (-b)
	"recursion", 	# Recursion stop size (-l)
	"window", 	# Window size (-w)
	"output", 	# Output parameters
	"quiet",
	"output_format", 	# Output format (-f)
	"suppress_output", 	# Suppress output about progress of the program (-o)

    ];

    $self->{TYPE}  = {
	"dca" => 'String',
	"seq" => 'Sequence',
	"outfile" => 'Results',
	"control" => 'Paragraph',
	"cost" => 'Excl',
	"gaps" => 'Switch',
	"approximate" => 'Switch',
	"intensity" => 'Float',
	"recursion" => 'Integer',
	"window" => 'Integer',
	"output" => 'Paragraph',
	"quiet" => 'Switch',
	"output_format" => 'Excl',
	"suppress_output" => 'Switch',

    };

    $self->{FORMAT}  = {
	"dca" => {
		"perl" => '"dca"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"outfile" => {
	},
	"control" => {
	},
	"cost" => {
		"perl" => '($value)? " -c $value" : "" ',
	},
	"gaps" => {
		"perl" => ' ($value)? " -g":""',
	},
	"approximate" => {
		"perl" => ' ($value)? " -a":""',
	},
	"intensity" => {
		"perl" => ' (defined $value && $value != $vdef)? " -b $value" : "" ',
	},
	"recursion" => {
		"perl" => ' ($value && $value != $vdef)? " -l $value" : "" ',
	},
	"window" => {
		"perl" => ' ($value != $vdef)? " -w $value" : "" ',
	},
	"output" => {
	},
	"quiet" => {
		"perl" => '" -q"',
	},
	"output_format" => {
		"perl" => '($value && $value ne $vdef)? " -f $value" : "" ',
	},
	"suppress_output" => {
		"perl" => ' ($value)? " -o":""',
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'dca.out',

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"dca" => 0,
	"seq" => 100,
	"cost" => 1,
	"gaps" => 1,
	"approximate" => 1,
	"intensity" => 1,
	"recursion" => 1,
	"window" => 1,
	"quiet" => 1,
	"output_format" => 1,
	"suppress_output" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"dca",
	"output",
	"outfile",
	"control",
	"cost",
	"gaps",
	"approximate",
	"intensity",
	"recursion",
	"window",
	"quiet",
	"output_format",
	"suppress_output",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dca" => 1,
	"seq" => 0,
	"outfile" => 0,
	"control" => 0,
	"cost" => 0,
	"gaps" => 0,
	"approximate" => 0,
	"intensity" => 0,
	"recursion" => 0,
	"window" => 0,
	"output" => 0,
	"quiet" => 1,
	"output_format" => 0,
	"suppress_output" => 0,

    };

    $self->{ISCOMMAND}  = {
	"dca" => 1,
	"seq" => 0,
	"outfile" => 0,
	"control" => 0,
	"cost" => 0,
	"gaps" => 0,
	"approximate" => 0,
	"intensity" => 0,
	"recursion" => 0,
	"window" => 0,
	"output" => 0,
	"quiet" => 0,
	"output_format" => 0,
	"suppress_output" => 0,

    };

    $self->{ISMANDATORY}  = {
	"dca" => 0,
	"seq" => 1,
	"outfile" => 0,
	"control" => 0,
	"cost" => 0,
	"gaps" => 0,
	"approximate" => 0,
	"intensity" => 0,
	"recursion" => 0,
	"window" => 0,
	"output" => 0,
	"quiet" => 0,
	"output_format" => 0,
	"suppress_output" => 0,

    };

    $self->{PROMPT}  = {
	"dca" => "",
	"seq" => "Sequences File",
	"outfile" => "",
	"control" => "Control parameters",
	"cost" => "Cost matrix (default: depends on sequences) (-c)",
	"gaps" => "Penalize end gaps as internal gaps (default: free shift) (-g)",
	"approximate" => "Use approximate cut positions (-a)",
	"intensity" => "Weight intensity (-b)",
	"recursion" => "Recursion stop size (-l)",
	"window" => "Window size (-w)",
	"output" => "Output parameters",
	"quiet" => "",
	"output_format" => "Output format (-f)",
	"suppress_output" => "Suppress output about progress of the program (-o)",

    };

    $self->{ISSTANDOUT}  = {
	"dca" => 0,
	"seq" => 0,
	"outfile" => 0,
	"control" => 0,
	"cost" => 0,
	"gaps" => 0,
	"approximate" => 0,
	"intensity" => 0,
	"recursion" => 0,
	"window" => 0,
	"output" => 0,
	"quiet" => 0,
	"output_format" => 0,
	"suppress_output" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['cost','gaps','approximate','intensity','recursion','window',],
	"cost" => ['blosum30','blosum30','blosum45','blosum45','blosum62','blosum62','pam160','pam160','pam250','pam250','unitcost','unitcost','dna','dna','rna','rna','dnarna','dnarna',],
	"output" => ['quiet','output_format','suppress_output',],
	"output_format" => ['1','1 (aln)','2','2 (fasta)','3','3 (nex)','4','4 (dca)',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gaps" => '0',
	"approximate" => '1',
	"intensity" => '0.0',
	"recursion" => '30',
	"window" => '0',
	"output_format" => '2',
	"suppress_output" => '1',

    };

    $self->{PRECOND}  = {
	"dca" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"cost" => { "perl" => '1' },
	"gaps" => { "perl" => '1' },
	"approximate" => { "perl" => '1' },
	"intensity" => { "perl" => '1' },
	"recursion" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"quiet" => { "perl" => '1' },
	"output_format" => { "perl" => '1' },
	"suppress_output" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"intensity" => {
		"perl" => {
			'$intensity < 0.0 || $intensity > 1.0' => "Weight intensity must be >= 0.0 and <= 1.0",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '$suppress_output && ($output_format eq "2" || $output_format eq "3") ' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"dca" => 0,
	"seq" => 0,
	"outfile" => 0,
	"control" => 0,
	"cost" => 0,
	"gaps" => 0,
	"approximate" => 0,
	"intensity" => 0,
	"recursion" => 0,
	"window" => 0,
	"output" => 0,
	"quiet" => 0,
	"output_format" => 0,
	"suppress_output" => 0,

    };

    $self->{ISSIMPLE}  = {
	"dca" => 1,
	"seq" => 1,
	"outfile" => 0,
	"control" => 0,
	"cost" => 0,
	"gaps" => 0,
	"approximate" => 0,
	"intensity" => 0,
	"recursion" => 0,
	"window" => 0,
	"output" => 0,
	"quiet" => 0,
	"output_format" => 0,
	"suppress_output" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"approximate" => [
		"On: FastDCA (use approximate cut positions); Off: slower, more accurate algorithm (search for eaxct cut positions)",
	],
	"recursion" => [
		"5 ... 100 recommended; small: faster algorithm, maybe worse.",
	],
	"window" => [
		"To correct the alignment in the proximity of division sites, the sequences can be re-aligned inside a window of size w >= 0 placed across each slicing site.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dca.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

