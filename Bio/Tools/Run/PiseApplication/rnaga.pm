# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::rnaga
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::rnaga

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnaga

      Bioperl class for:

	RNAGA	Prediction of common secondary structures of RNAs by genetic algorithm (Chen, Le, Maizel)

	References:

		Jih-H Chen, Shu-Yun Le and Jacob Maize. Prediction of Common Secondary Structures of RNAs: A genetic Algorithm Approach, Nucleic Acids Res.,2000, Vol.28, No. 4 (991 - 999).



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/rnaga.html 
         for available values):


		rnaga (String)

		mv_files (String)

		seqfile (Sequence)
			Sequence(s)
			pipe: seqsfile

		hcrtval (Float)
			Hcrtval: a structure is considered as a candidate of common structure during a GA iteration if the conservation score for the structure is no less than Hcrtval

		hcrtval2 (Float)
			Hcrtval2: a structure is taken as a common secondary structure by the program if the adjusted conservation score for the structure is no less than Hcrtval2 (Normally, Hcrtval2 < Hcrtval)

		pns (Float)
			pns: a criterion to make sure that the structure feature in a common structure is shared by majority of the sequences (pns = 0.6 means shared by at least 60% of the sequences)

		structures_nb (Integer)
			Number of structures in a population

		iterations_nb (Integer)
			Number of GA iterations

		beta (Float)
			beta: a structure is considered as a candidate during a GA iteration if the free energy of the structure is no greater than (average random energy + beta * standard deviation)

		zeta (Float)
			zeta: a structure is taken as a common structure if the free energy of the structure is no greater than (average random energy + zeta * standard deviation)

		mxdp (Integer)
			Stem position

		mxdr (Integer)
			Region size

		mxdL (Integer)
			Loop size

		mxdrp (Integer)
			Branches distance

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

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

http://bioweb.pasteur.fr/seqanal/interfaces/rnaga.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::rnaga;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnaga = Bio::Tools::Run::PiseApplication::rnaga->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnaga object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $rnaga = $factory->program('rnaga');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnaga.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnaga.pm

    $self->{COMMAND}   = "rnaga";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "RNAGA";

    $self->{DESCRIPTION}   = "Prediction of common secondary structures of RNAs by genetic algorithm";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Chen, Le, Maizel";

    $self->{REFERENCE}   = [

         "Jih-H Chen, Shu-Yun Le and Jacob Maize. Prediction of Common Secondary Structures of RNAs: A genetic Algorithm Approach, Nucleic Acids Res.,2000, Vol.28, No. 4 (991 - 999).",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnaga",
	"mv_files",
	"result_files",
	"seqfile",
	"hcrtval",
	"hcrtval2",
	"pns",
	"structures_nb",
	"iterations_nb",
	"beta",
	"zeta",
	"equivalency",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnaga",
	"mv_files",
	"result_files",
	"seqfile", 	# Sequence(s)
	"hcrtval", 	# Hcrtval: a structure is considered as a candidate of common structure during a GA iteration if the conservation score for the structure is no less than Hcrtval
	"hcrtval2", 	# Hcrtval2: a structure is taken as a common secondary structure by the program if the adjusted conservation score for the structure is no less than Hcrtval2 (Normally, Hcrtval2 < Hcrtval)
	"pns", 	# pns: a criterion to make sure that the structure feature in a common structure is shared by majority of the sequences (pns = 0.6 means shared by at least 60% of the sequences)
	"structures_nb", 	# Number of structures in a population
	"iterations_nb", 	# Number of GA iterations
	"beta", 	# beta: a structure is considered as a candidate during a GA iteration if the free energy of the structure is no greater than (average random energy + beta * standard deviation)
	"zeta", 	# zeta: a structure is taken as a common structure if the free energy of the structure is no greater than (average random energy + zeta * standard deviation)
	"equivalency", 	# Parameters to determine the equivalency of two stems
	"mxdp", 	# Stem position
	"mxdr", 	# Region size
	"mxdL", 	# Loop size
	"mxdrp", 	# Branches distance

    ];

    $self->{TYPE}  = {
	"rnaga" => 'String',
	"mv_files" => 'String',
	"result_files" => 'Results',
	"seqfile" => 'Sequence',
	"hcrtval" => 'Float',
	"hcrtval2" => 'Float',
	"pns" => 'Float',
	"structures_nb" => 'Integer',
	"iterations_nb" => 'Integer',
	"beta" => 'Float',
	"zeta" => 'Float',
	"equivalency" => 'Paragraph',
	"mxdp" => 'Integer',
	"mxdr" => 'Integer',
	"mxdL" => 'Integer',
	"mxdrp" => 'Integer',

    };

    $self->{FORMAT}  = {
	"rnaga" => {
		"perl" => ' "rnaga < params" ',
	},
	"mv_files" => {
		"perl" => '" ; mv fort.2 $seqfile.scr; mv fort.4 $seqfile.cm"',
	},
	"result_files" => {
	},
	"seqfile" => {
		"perl" => '"$value\n"',
	},
	"hcrtval" => {
		"perl" => '" $value"',
	},
	"hcrtval2" => {
		"perl" => '",$value"',
	},
	"pns" => {
		"perl" => '",$value\n"',
	},
	"structures_nb" => {
		"perl" => '" $value"',
	},
	"iterations_nb" => {
		"perl" => '",$value\n"',
	},
	"beta" => {
		"perl" => '" $value"',
	},
	"zeta" => {
		"perl" => '",$value\n"',
	},
	"equivalency" => {
	},
	"mxdp" => {
		"perl" => '" $value"',
	},
	"mxdr" => {
		"perl" => '",$value"',
	},
	"mxdL" => {
		"perl" => '",$value"',
	},
	"mxdrp" => {
		"perl" => '",$value\n\n"',
	},

    };

    $self->{FILENAMES}  = {
	"result_files" => '*.scr *.cm params',

    };

    $self->{SEQFMT}  = {
	"seqfile" => [1,2,3,4,9],

    };

    $self->{GROUP}  = {
	"rnaga" => 0,
	"mv_files" => 100,
	"seqfile" => 1,
	"hcrtval" => 2,
	"hcrtval2" => 3,
	"pns" => 4,
	"structures_nb" => 5,
	"iterations_nb" => 6,
	"beta" => 7,
	"zeta" => 8,
	"mxdp" => 9,
	"mxdr" => 10,
	"mxdL" => 11,
	"mxdrp" => 12,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"rnaga",
	"equivalency",
	"result_files",
	"seqfile",
	"hcrtval",
	"hcrtval2",
	"pns",
	"structures_nb",
	"iterations_nb",
	"beta",
	"zeta",
	"mxdp",
	"mxdr",
	"mxdL",
	"mxdrp",
	"mv_files",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnaga" => 1,
	"mv_files" => 1,
	"result_files" => 0,
	"seqfile" => 0,
	"hcrtval" => 0,
	"hcrtval2" => 0,
	"pns" => 0,
	"structures_nb" => 0,
	"iterations_nb" => 0,
	"beta" => 0,
	"zeta" => 0,
	"equivalency" => 0,
	"mxdp" => 0,
	"mxdr" => 0,
	"mxdL" => 0,
	"mxdrp" => 0,

    };

    $self->{ISCOMMAND}  = {
	"rnaga" => 1,
	"mv_files" => 1,
	"result_files" => 0,
	"seqfile" => 0,
	"hcrtval" => 0,
	"hcrtval2" => 0,
	"pns" => 0,
	"structures_nb" => 0,
	"iterations_nb" => 0,
	"beta" => 0,
	"zeta" => 0,
	"equivalency" => 0,
	"mxdp" => 0,
	"mxdr" => 0,
	"mxdL" => 0,
	"mxdrp" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnaga" => 0,
	"mv_files" => 0,
	"result_files" => 0,
	"seqfile" => 1,
	"hcrtval" => 1,
	"hcrtval2" => 1,
	"pns" => 1,
	"structures_nb" => 1,
	"iterations_nb" => 1,
	"beta" => 1,
	"zeta" => 1,
	"equivalency" => 0,
	"mxdp" => 1,
	"mxdr" => 1,
	"mxdL" => 1,
	"mxdrp" => 1,

    };

    $self->{PROMPT}  = {
	"rnaga" => "",
	"mv_files" => "",
	"result_files" => "",
	"seqfile" => "Sequence(s)",
	"hcrtval" => "Hcrtval: a structure is considered as a candidate of common structure during a GA iteration if the conservation score for the structure is no less than Hcrtval",
	"hcrtval2" => "Hcrtval2: a structure is taken as a common secondary structure by the program if the adjusted conservation score for the structure is no less than Hcrtval2 (Normally, Hcrtval2 < Hcrtval)",
	"pns" => "pns: a criterion to make sure that the structure feature in a common structure is shared by majority of the sequences (pns = 0.6 means shared by at least 60% of the sequences)",
	"structures_nb" => "Number of structures in a population",
	"iterations_nb" => "Number of GA iterations",
	"beta" => "beta: a structure is considered as a candidate during a GA iteration if the free energy of the structure is no greater than (average random energy + beta * standard deviation)",
	"zeta" => "zeta: a structure is taken as a common structure if the free energy of the structure is no greater than (average random energy + zeta * standard deviation)",
	"equivalency" => "Parameters to determine the equivalency of two stems",
	"mxdp" => "Stem position",
	"mxdr" => "Region size",
	"mxdL" => "Loop size",
	"mxdrp" => "Branches distance",

    };

    $self->{ISSTANDOUT}  = {
	"rnaga" => 0,
	"mv_files" => 0,
	"result_files" => 0,
	"seqfile" => 0,
	"hcrtval" => 0,
	"hcrtval2" => 0,
	"pns" => 0,
	"structures_nb" => 0,
	"iterations_nb" => 0,
	"beta" => 0,
	"zeta" => 0,
	"equivalency" => 0,
	"mxdp" => 0,
	"mxdr" => 0,
	"mxdL" => 0,
	"mxdrp" => 0,

    };

    $self->{VLIST}  = {

	"equivalency" => ['mxdp','mxdr','mxdL','mxdrp',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"hcrtval" => '0.8',
	"hcrtval2" => '0.7',
	"pns" => '0.6',
	"structures_nb" => '200',
	"iterations_nb" => '100',
	"beta" => '-1.5',
	"zeta" => '-1.5',
	"mxdp" => '3',
	"mxdr" => '3',
	"mxdL" => '3',
	"mxdrp" => '3',

    };

    $self->{PRECOND}  = {
	"rnaga" => { "perl" => '1' },
	"mv_files" => { "perl" => '1' },
	"result_files" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"hcrtval" => { "perl" => '1' },
	"hcrtval2" => { "perl" => '1' },
	"pns" => { "perl" => '1' },
	"structures_nb" => { "perl" => '1' },
	"iterations_nb" => { "perl" => '1' },
	"beta" => { "perl" => '1' },
	"zeta" => { "perl" => '1' },
	"equivalency" => { "perl" => '1' },
	"mxdp" => { "perl" => '1' },
	"mxdr" => { "perl" => '1' },
	"mxdL" => { "perl" => '1' },
	"mxdrp" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqfile" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"rnaga" => 0,
	"mv_files" => 0,
	"result_files" => 0,
	"seqfile" => 0,
	"hcrtval" => 0,
	"hcrtval2" => 0,
	"pns" => 0,
	"structures_nb" => 0,
	"iterations_nb" => 0,
	"beta" => 0,
	"zeta" => 0,
	"equivalency" => 0,
	"mxdp" => 0,
	"mxdr" => 0,
	"mxdL" => 0,
	"mxdrp" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnaga" => 0,
	"mv_files" => 0,
	"result_files" => 0,
	"seqfile" => 0,
	"hcrtval" => 0,
	"hcrtval2" => 0,
	"pns" => 0,
	"structures_nb" => 0,
	"iterations_nb" => 0,
	"beta" => 0,
	"zeta" => 0,
	"equivalency" => 0,
	"mxdp" => 0,
	"mxdr" => 0,
	"mxdL" => 0,
	"mxdrp" => 0,

    };

    $self->{PARAMFILE}  = {
	"seqfile" => "params",
	"hcrtval" => "params",
	"hcrtval2" => "params",
	"pns" => "params",
	"structures_nb" => "params",
	"iterations_nb" => "params",
	"beta" => "params",
	"zeta" => "params",
	"mxdp" => "params",
	"mxdr" => "params",
	"mxdL" => "params",
	"mxdrp" => "params",

    };

    $self->{COMMENT}  = {
	"hcrtval" => [
		"If the program produces too many possible common secondary structures, such as 10**5, the computation cost for the second stage maybe huge. In this case, to reduce the computation time, you may want to increase the value of Hcrtval and/or decrease the value of beta. Also, in our experience the default value of beta can be 0.5.",
	],
	"structures_nb" => [
		"A value of 100 is suggested for sequences of less than 100 nucleotides.",
	],
	"beta" => [
		"increase this value by 0.5 each time if the program  terminate with the message:  No structure is sufficiently stable",
		"If the program produces too many possible common secondary structures, such as 10**5, the computation cost for the second stage maybe huge. In this case, to reduce the computation time, you may want to increase the value of Hcrtval and/or decrease the value of beta. Also, in our experience the default value of beta can be 0.5.",
	],
	"zeta" => [
		"increase this value by 0.5 each time if the program  terminate with the message:  No structure is sufficiently stable",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnaga.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

