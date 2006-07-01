# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::lvb
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::lvb

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::lvb

      Bioperl class for:

	LVB	Reconstructing Evolution With Parsimony And Simulated Annealing (D. Barker)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/lvb.html 
         for available values):


		lvb (String)

		infile (Sequence)
			Alignement File
			pipe: readseq_ok_alig

		convert (Switch)
			Convert the alignment file to LVB format

		method (Excl)
			Search method (method)

		seed (Integer)
			Seed for the random number generator (seed)

		t0 (Float)
			Initial temperature (0 < t0 <= 1.0) (t0)

		t1 (Float)
			Second temperature (0 < t1 <= 1.0 and t1 < t0) (t1)

		maxaccept (Integer)
			How many new trees are accepted (maxaccept)

		maxpropose (Integer)
			How many changes are proposed (maxpropose)

		maxfail (Integer)
			How many 'failed' successive temperatures to allow (maxfail)

		equivalent (Excl)
			Equivalent characters sets (equivalent)

		matchchar (Switch)
			Mark similar characters relative to the first row by a dot (matchchar)

		ignorechars (Excl)
			Ignore characters containing (ignorechars)

		outgroup (String)
			Name of the outgroup (outgroup)

		runs (Integer)
			Number of runs (runs)

		verbose (Switch)
			Statistics (verbose)

		titleprec (Switch)
			Comment out titles in tabulated statistics (titleprec)

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

http://bioweb.pasteur.fr/seqanal/interfaces/lvb.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::lvb;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $lvb = Bio::Tools::Run::PiseApplication::lvb->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::lvb object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $lvb = $factory->program('lvb');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::lvb.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lvb.pm

    $self->{COMMAND}   = "lvb";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "LVB";

    $self->{DESCRIPTION}   = "Reconstructing Evolution With Parsimony And Simulated Annealing";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "D. Barker";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"lvb",
	"params",
	"res",
	"other_results",
	"infile",
	"convert",
	"method",
	"seed",
	"t0",
	"t1",
	"maxaccept",
	"maxpropose",
	"maxfail",
	"equivalent",
	"matchchar",
	"ignorechars",
	"outgroup",
	"runs",
	"verbose",
	"titleprec",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"lvb",
	"params",
	"res",
	"other_results",
	"infile", 	# Alignement File
	"convert", 	# Convert the alignment file to LVB format
	"method", 	# Search method (method)
	"seed", 	# Seed for the random number generator (seed)
	"t0", 	# Initial temperature (0 < t0 <= 1.0) (t0)
	"t1", 	# Second temperature (0 < t1 <= 1.0 and t1 < t0) (t1)
	"maxaccept", 	# How many new trees are accepted (maxaccept)
	"maxpropose", 	# How many changes are proposed (maxpropose)
	"maxfail", 	# How many 'failed' successive temperatures to allow (maxfail)
	"equivalent", 	# Equivalent characters sets (equivalent)
	"matchchar", 	# Mark similar characters relative to the first row by a dot (matchchar)
	"ignorechars", 	# Ignore characters containing (ignorechars)
	"outgroup", 	# Name of the outgroup (outgroup)
	"runs", 	# Number of runs (runs)
	"verbose", 	# Statistics (verbose)
	"titleprec", 	# Comment out titles in tabulated statistics (titleprec)

    ];

    $self->{TYPE}  = {
	"lvb" => 'String',
	"params" => 'Results',
	"res" => 'Results',
	"other_results" => 'Results',
	"infile" => 'Sequence',
	"convert" => 'Switch',
	"method" => 'Excl',
	"seed" => 'Integer',
	"t0" => 'Float',
	"t1" => 'Float',
	"maxaccept" => 'Integer',
	"maxpropose" => 'Integer',
	"maxfail" => 'Integer',
	"equivalent" => 'Excl',
	"matchchar" => 'Switch',
	"ignorechars" => 'Excl',
	"outgroup" => 'String',
	"runs" => 'Integer',
	"verbose" => 'Switch',
	"titleprec" => 'Switch',

    };

    $self->{FORMAT}  = {
	"lvb" => {
		"perl" => '($convert)? "readseq -p -f11 < $infile > $infile.11; phy2lvb $infile.11 > data; lvb" : "ln -s $infile data; lvb"',
	},
	"params" => {
	},
	"res" => {
	},
	"other_results" => {
	},
	"infile" => {
		"perl" => ' "" ',
	},
	"convert" => {
		"perl" => '""',
	},
	"method" => {
		"perl" => '"method $value\\n"',
	},
	"seed" => {
		"perl" => '($value)? "seed $value\\n" : ""',
	},
	"t0" => {
		"perl" => '"t0 $value\\n"',
	},
	"t1" => {
		"perl" => '"t1 $value\\n"',
	},
	"maxaccept" => {
		"perl" => '"maxaccept $value\\n"',
	},
	"maxpropose" => {
		"perl" => '"maxpropose $value\\n"',
	},
	"maxfail" => {
		"perl" => '"maxfail $value\\n"',
	},
	"equivalent" => {
		"perl" => '"equivalent $value\\n"',
	},
	"matchchar" => {
		"perl" => '($value)? "matchchar .\\n" : "matchchar none\\n"',
	},
	"ignorechars" => {
		"perl" => '($value)? "ignorechars $value\\n" : ""',
	},
	"outgroup" => {
		"perl" => '($value)? "outgroup $value\\n" : "outgroup none\\n"',
	},
	"runs" => {
		"perl" => '($value)? "runs $value\\n" : ""',
	},
	"verbose" => {
		"perl" => '($value)? "verbose 1\\n" : ""',
	},
	"titleprec" => {
		"perl" => '($value)? "titleprec #\\n" : "titleprec none\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"params" => 'params',
	"res" => 'res*',
	"other_results" => 'stat* sum log data ini*',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"lvb" => 0,
	"infile" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"lvb",
	"params",
	"res",
	"other_results",
	"convert",
	"method",
	"seed",
	"t0",
	"t1",
	"maxaccept",
	"maxpropose",
	"maxfail",
	"equivalent",
	"matchchar",
	"ignorechars",
	"outgroup",
	"runs",
	"verbose",
	"titleprec",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"lvb" => 1,
	"params" => 0,
	"res" => 0,
	"other_results" => 0,
	"infile" => 0,
	"convert" => 0,
	"method" => 0,
	"seed" => 0,
	"t0" => 0,
	"t1" => 0,
	"maxaccept" => 0,
	"maxpropose" => 0,
	"maxfail" => 0,
	"equivalent" => 0,
	"matchchar" => 0,
	"ignorechars" => 0,
	"outgroup" => 0,
	"runs" => 0,
	"verbose" => 0,
	"titleprec" => 0,

    };

    $self->{ISCOMMAND}  = {
	"lvb" => 1,
	"params" => 0,
	"res" => 0,
	"other_results" => 0,
	"infile" => 0,
	"convert" => 0,
	"method" => 0,
	"seed" => 0,
	"t0" => 0,
	"t1" => 0,
	"maxaccept" => 0,
	"maxpropose" => 0,
	"maxfail" => 0,
	"equivalent" => 0,
	"matchchar" => 0,
	"ignorechars" => 0,
	"outgroup" => 0,
	"runs" => 0,
	"verbose" => 0,
	"titleprec" => 0,

    };

    $self->{ISMANDATORY}  = {
	"lvb" => 0,
	"params" => 0,
	"res" => 0,
	"other_results" => 0,
	"infile" => 1,
	"convert" => 0,
	"method" => 1,
	"seed" => 1,
	"t0" => 1,
	"t1" => 1,
	"maxaccept" => 1,
	"maxpropose" => 1,
	"maxfail" => 1,
	"equivalent" => 1,
	"matchchar" => 0,
	"ignorechars" => 0,
	"outgroup" => 0,
	"runs" => 0,
	"verbose" => 0,
	"titleprec" => 0,

    };

    $self->{PROMPT}  = {
	"lvb" => "",
	"params" => "",
	"res" => "",
	"other_results" => "",
	"infile" => "Alignement File",
	"convert" => "Convert the alignment file to LVB format",
	"method" => "Search method (method)",
	"seed" => "Seed for the random number generator (seed)",
	"t0" => "Initial temperature (0 < t0 <= 1.0) (t0)",
	"t1" => "Second temperature (0 < t1 <= 1.0 and t1 < t0) (t1)",
	"maxaccept" => "How many new trees are accepted (maxaccept)",
	"maxpropose" => "How many changes are proposed (maxpropose)",
	"maxfail" => "How many 'failed' successive temperatures to allow (maxfail)",
	"equivalent" => "Equivalent characters sets (equivalent)",
	"matchchar" => "Mark similar characters relative to the first row by a dot (matchchar)",
	"ignorechars" => "Ignore characters containing (ignorechars)",
	"outgroup" => "Name of the outgroup (outgroup)",
	"runs" => "Number of runs (runs)",
	"verbose" => "Statistics (verbose)",
	"titleprec" => "Comment out titles in tabulated statistics (titleprec)",

    };

    $self->{ISSTANDOUT}  = {
	"lvb" => 0,
	"params" => 0,
	"res" => 0,
	"other_results" => 0,
	"infile" => 0,
	"convert" => 0,
	"method" => 0,
	"seed" => 0,
	"t0" => 0,
	"t1" => 0,
	"maxaccept" => 0,
	"maxpropose" => 0,
	"maxfail" => 0,
	"equivalent" => 0,
	"matchchar" => 0,
	"ignorechars" => 0,
	"outgroup" => 0,
	"runs" => 0,
	"verbose" => 0,
	"titleprec" => 0,

    };

    $self->{VLIST}  = {

	"method" => ['anneal','anneal: simulated annealing','hillclimb','hillclimb: hill climbing (steepest descent)','randomwalk','randomwalk: random walk',],
	"equivalent" => ['none','none: no equivalent characters sets','-?N,AG,CT','3 sets = missing data, purine and pyrimidine (-?N,AG,CT)','-?+N,AGR,CTY','Same as above with ambiguous characters (-?+N,AGR,CTY)','-?+WSMKHBVDN,AGR,CTY','As above, with ambiguous for purine vs pyrimidine treated as missing (-?+WSMKHBVDN,AGR,CTY)',],
	"ignorechars" => ['none','none','-','-','?','?','+','+','-?+','-?+','RYWSMKHBVDN-?+','RYWSMKHBVDN-?+','01','01','ACTGRYWSMKHBVDN','ACTGRYWSMKHBVDN',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"convert" => '1',
	"method" => 'anneal',
	"t0" => '1.0',
	"t1" => '0.9',
	"maxaccept" => '50',
	"maxpropose" => '5000',
	"maxfail" => '2',
	"equivalent" => 'none',
	"ignorechars" => 'none',
	"runs" => '2',
	"verbose" => '0',
	"titleprec" => '1',

    };

    $self->{PRECOND}  = {
	"lvb" => { "perl" => '1' },
	"params" => { "perl" => '1' },
	"res" => { "perl" => '1' },
	"other_results" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"convert" => { "perl" => '1' },
	"method" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"t0" => { "perl" => '1' },
	"t1" => { "perl" => '1' },
	"maxaccept" => { "perl" => '1' },
	"maxpropose" => { "perl" => '1' },
	"maxfail" => { "perl" => '1' },
	"equivalent" => { "perl" => '1' },
	"matchchar" => { "perl" => '1' },
	"ignorechars" => { "perl" => '1' },
	"outgroup" => { "perl" => '1' },
	"runs" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"titleprec" => {
		"perl" => '$verbose',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"res" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"lvb" => 0,
	"params" => 0,
	"res" => 0,
	"other_results" => 0,
	"infile" => 0,
	"convert" => 0,
	"method" => 0,
	"seed" => 0,
	"t0" => 0,
	"t1" => 0,
	"maxaccept" => 0,
	"maxpropose" => 0,
	"maxfail" => 0,
	"equivalent" => 0,
	"matchchar" => 0,
	"ignorechars" => 0,
	"outgroup" => 0,
	"runs" => 0,
	"verbose" => 0,
	"titleprec" => 0,

    };

    $self->{ISSIMPLE}  = {
	"lvb" => 0,
	"params" => 0,
	"res" => 0,
	"other_results" => 0,
	"infile" => 1,
	"convert" => 0,
	"method" => 0,
	"seed" => 0,
	"t0" => 0,
	"t1" => 0,
	"maxaccept" => 0,
	"maxpropose" => 0,
	"maxfail" => 0,
	"equivalent" => 0,
	"matchchar" => 0,
	"ignorechars" => 0,
	"outgroup" => 0,
	"runs" => 0,
	"verbose" => 0,
	"titleprec" => 0,

    };

    $self->{PARAMFILE}  = {
	"method" => "params",
	"seed" => "params",
	"t0" => "params",
	"t1" => "params",
	"maxaccept" => "params",
	"maxpropose" => "params",
	"maxfail" => "params",
	"equivalent" => "params",
	"matchchar" => "params",
	"ignorechars" => "params",
	"outgroup" => "params",
	"runs" => "params",
	"verbose" => "params",
	"titleprec" => "params",

    };

    $self->{COMMENT}  = {
	"infile" => [
		"You had better provide a Phylip, MSF or FASTA formatted alignment. Clustalw format will ***not*** work for this service. You may use the readseq form on the same server to convert your clustalw alignment to a Phylip interleaved format (12).",
	],
	"convert" => [
		"You had better provide a Phylip, MSF or FASTA formatted alignment. Clustalw format will ***not*** work for this service. You may use the readseq form on the same server to convert your clustalw alignment to a Phylip interleaved format (12).",
	],
	"method" => [
		"The random walk is a simple and ineffective method that is given for comparison only",
		"Hill climbing is better in practice, when an infinite amount of trees cannot be examined. This approach is like trying to reach the top of a mountain range by only ever walking up hill.",
		"Simulated annealing (Kirkpatrick et al. 1983) is better in that it will occasionally accept worse trees, with the aim of obtaining even shorter ones in the long run.",
		"Here are some general purpose parameters we would suggest, based on many runs with average size sequence alignments (method anneal):",
		"t0 0.01",
		"t1 0.0099",
		"maxpropose 5000",
		"maxaccept 5",
		"maxfail 3",
	],
	"t0" => [
		"t0 and t1 should not be given very low values, since the effect would be similar to hillclimbing.",
		"Temperatures other than the initial temperature are obtained by Tn = (T1/T0)^n * T0, where n = 1 for the second temperature and increases by 1 with each temperature change.",
	],
	"maxaccept" => [
		"At each temperature, enough changes are considered that either \'maxaccept\' new trees are accepted or \'maxpropose\' changes are considered, whichever occurs sooner. If less than \'maxaccept\' new trees are accepted in each of \'maxfail\' successive temperatures, the system is considered frozen, and the run stops.",
	],
	"equivalent" => [
		"It is possible to tell LVB that some biological character states are equivalent to others, in which case those states will be treated as if they were the same. ",
	],
	"matchchar" => [
		"Sometimes, only the first row of the matrix is given in full. In subsequent rows, a fixed symbol (here a dot) is then used to indicate that the cell contains the same character state as in the first row.",
	],
	"ignorechars" => [
		"- ? + and -?+ take care of separate representations for unknown or absent. RYWSMKHBVDN-?+ will ignore all characters containing missing, unknown or ambiguous nucleotides, and ACTGRYWSMKHBVDN will ignore all nucleotides (IUPAC)",
	],
	"outgroup" => [
		"Possible values are the title of any row in the matrix,or none.",
	],
	"runs" => [
		"The number of times you wish to apply the search method. Each run starts with a different random tree, and produces different statistics and tree files.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lvb.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

