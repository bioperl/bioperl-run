# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::saps
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::saps

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::saps

      Bioperl class for:

	SAPS	Statistical Analysis of Protein Sequences (V. Brendel)

	References:

		Brendel, V., Bucher, P., Nourbakhsh, I., Blaisdell, B.E., Karlin, S. (1992) Methods and algorithms for statistical analysis of protein sequences. Proc. Natl. Acad. Sci. USA 89: 2002-2006. 



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/saps.html 
         for available values):


		saps (String)

		seq (Sequence)
			Protein sequence(s) File
			pipe: seqfile

		documented (Switch)
			Generate documented output (-d)

		terse (Switch)
			Generate terse output (-t)

		verbose (Switch)
			Generate verbose output (-v)

		table (Switch)
			Append computer-readable table summary output (-T)

		specie (Excl)
			Use this specie for quantile comparisons (-s)

		H_positive (Switch)
			Count H as positive charge (-H)

		analyze (String)
			Analyze spacings of amino acids X, Y, .... (-a)

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

http://bioweb.pasteur.fr/seqanal/interfaces/saps.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::saps;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $saps = Bio::Tools::Run::PiseApplication::saps->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::saps object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $saps = $factory->program('saps');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::saps.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/saps.pm

    $self->{COMMAND}   = "saps";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAPS";

    $self->{DESCRIPTION}   = "Statistical Analysis of Protein Sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{AUTHORS}   = "V. Brendel";

    $self->{REFERENCE}   = [

         "Brendel, V., Bucher, P., Nourbakhsh, I., Blaisdell, B.E., Karlin, S. (1992) Methods and algorithms for statistical analysis of protein sequences. Proc. Natl. Acad. Sci. USA 89: 2002-2006. ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"saps",
	"seq",
	"output",
	"control",
	"tablefile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"saps",
	"seq", 	# Protein sequence(s) File
	"output", 	# Output options
	"documented", 	# Generate documented output (-d)
	"terse", 	# Generate terse output (-t)
	"verbose", 	# Generate verbose output (-v)
	"table", 	# Append computer-readable table summary output (-T)
	"control", 	# Control options
	"specie", 	# Use this specie for quantile comparisons (-s)
	"H_positive", 	# Count H as positive charge (-H)
	"analyze", 	# Analyze spacings of amino acids X, Y, .... (-a)
	"tablefile",

    ];

    $self->{TYPE}  = {
	"saps" => 'String',
	"seq" => 'Sequence',
	"output" => 'Paragraph',
	"documented" => 'Switch',
	"terse" => 'Switch',
	"verbose" => 'Switch',
	"table" => 'Switch',
	"control" => 'Paragraph',
	"specie" => 'Excl',
	"H_positive" => 'Switch',
	"analyze" => 'String',
	"tablefile" => 'Results',

    };

    $self->{FORMAT}  = {
	"saps" => {
		"seqlab" => 'saps',
		"perl" => '"saps"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"output" => {
	},
	"documented" => {
		"perl" => ' ($value)? " -d":""',
	},
	"terse" => {
		"perl" => ' ($value)? " -t":""',
	},
	"verbose" => {
		"perl" => ' ($value)? " -v":""',
	},
	"table" => {
		"perl" => ' ($value)? " -T":""',
	},
	"control" => {
	},
	"specie" => {
		"perl" => '($value && $value ne $vdef)? " -s $value" : "" ',
	},
	"H_positive" => {
		"perl" => ' ($value)? " -H":""',
	},
	"analyze" => {
		"perl" => ' ($value)? " -a $value":""',
	},
	"tablefile" => {
	},

    };

    $self->{FILENAMES}  = {
	"tablefile" => '*.table',

    };

    $self->{SEQFMT}  = {
	"seq" => [4],

    };

    $self->{GROUP}  = {
	"saps" => 0,
	"seq" => 2,
	"output" => 1,
	"documented" => 1,
	"terse" => 1,
	"verbose" => 1,
	"table" => 1,
	"control" => 1,
	"specie" => 1,
	"H_positive" => 1,
	"analyze" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"saps",
	"tablefile",
	"output",
	"documented",
	"terse",
	"verbose",
	"table",
	"control",
	"specie",
	"H_positive",
	"analyze",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"saps" => 1,
	"seq" => 0,
	"output" => 0,
	"documented" => 0,
	"terse" => 0,
	"verbose" => 0,
	"table" => 0,
	"control" => 0,
	"specie" => 0,
	"H_positive" => 0,
	"analyze" => 0,
	"tablefile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"saps" => 1,
	"seq" => 0,
	"output" => 0,
	"documented" => 0,
	"terse" => 0,
	"verbose" => 0,
	"table" => 0,
	"control" => 0,
	"specie" => 0,
	"H_positive" => 0,
	"analyze" => 0,
	"tablefile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"saps" => 0,
	"seq" => 1,
	"output" => 0,
	"documented" => 0,
	"terse" => 0,
	"verbose" => 0,
	"table" => 0,
	"control" => 0,
	"specie" => 0,
	"H_positive" => 0,
	"analyze" => 0,
	"tablefile" => 0,

    };

    $self->{PROMPT}  = {
	"saps" => "",
	"seq" => "Protein sequence(s) File",
	"output" => "Output options",
	"documented" => "Generate documented output (-d)",
	"terse" => "Generate terse output (-t)",
	"verbose" => "Generate verbose output (-v)",
	"table" => "Append computer-readable table summary output (-T)",
	"control" => "Control options",
	"specie" => "Use this specie for quantile comparisons (-s)",
	"H_positive" => "Count H as positive charge (-H)",
	"analyze" => "Analyze spacings of amino acids X, Y, .... (-a)",
	"tablefile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"saps" => 0,
	"seq" => 0,
	"output" => 0,
	"documented" => 0,
	"terse" => 0,
	"verbose" => 0,
	"table" => 0,
	"control" => 0,
	"specie" => 0,
	"H_positive" => 0,
	"analyze" => 0,
	"tablefile" => 0,

    };

    $self->{VLIST}  = {

	"output" => ['documented','terse','verbose','table',],
	"control" => ['specie','H_positive','analyze',],
	"specie" => ['BACSU','BACSU: Bacillus subtilis','DROME','DROME: Drosophila melanogaster','HUMAN','HUMAN: human','RAT','RAT: rat','YEAST','YEAST: Saccharomyces cerevisiae','CHICK','CHICK: chicken','ECOLI','ECOLI: Escherichia coli','MOUSE','MOUSE: mouse','XENLA','XENLA: frog','swp23s','swp23s: random sample of proteins from SWISS-PROT 23.0',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"documented" => '0',
	"terse" => '0',
	"verbose" => '0',
	"table" => '0',
	"specie" => 'swp23s',
	"H_positive" => '0',

    };

    $self->{PRECOND}  = {
	"saps" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"documented" => { "perl" => '1' },
	"terse" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"table" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"specie" => { "perl" => '1' },
	"H_positive" => { "perl" => '1' },
	"analyze" => { "perl" => '1' },
	"tablefile" => {
		"perl" => '$table',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"saps" => 0,
	"seq" => 0,
	"output" => 0,
	"documented" => 0,
	"terse" => 0,
	"verbose" => 0,
	"table" => 0,
	"control" => 0,
	"specie" => 0,
	"H_positive" => 0,
	"analyze" => 0,
	"tablefile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"saps" => 1,
	"seq" => 1,
	"output" => 0,
	"documented" => 0,
	"terse" => 0,
	"verbose" => 0,
	"table" => 0,
	"control" => 0,
	"specie" => 0,
	"H_positive" => 0,
	"analyze" => 0,
	"tablefile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"documented" => [
		"The output will come with documentation that annotates each part of the program; this flag should be set when SAPS is used for the first time as it provides helpful explanations with respect to the statistics being used and the layout of the output.",
	],
	"terse" => [
		"This flag specifies terse output that is limited to the analysis of the charge distribution and of high scoring segments.",
	],
	"table" => [
		"This flag is used in conjunction with the analysis of sets of proteins ; if specified, the file saps.table is appended with computer-readable lines describing the input files and their significant features.",
	],
	"H_positive" => [
		"By default, SAPS treats only lysine (K) and arginine (R) as positively charged residues. If the command line flag -H is set, then histidine (H) is also treated as positively charged in all parts of the program involving the charge alphabet.",
	],
	"analyze" => [
		"Clusters of particular amino acid types may be evaluated by means of the same tests that are used to detect clustering of charged residues (binomial model and scoring statistics). These tests are invoked by setting this flag; for example, to test (separately) for clusters of alanine (A) and serine (S), set thisparameter to AS. The binomial test is also programmed for certain combinations of amino acids: AG (flag -a a), PEST (flag -a p), QP (flag -a q), ST (flag -a s).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/saps.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

