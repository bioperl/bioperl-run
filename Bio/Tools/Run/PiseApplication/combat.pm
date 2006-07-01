# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::combat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::combat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::combat

      Bioperl class for:

	COMBAT	Comparison of coding DNA (Pedersen, Lyngso,Hein)

	References:

		Christian N. S. Pedersen, Rune B. Lyngso and Jotun Hein. Comparison of coding DNA in Proceedings of the 9th Annual Symposium of Combinatorial Pattern Matching (CPM), 1998.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/combat.html 
         for available values):


		combat (String)

		sequence1 (Sequence)
			First Sequence

		sequence2 (Sequence)
			Second Sequence

		output_aln (OutFile)

		alignment_file (OutFile)
			pipe: readseq_ok_alig

		protein_distance_matrix (Excl)
			Amino-acid distance matrix

		nucleotide_distance_matrix (Excl)
			Nucleotid distance matrix

		protein_gap_open (Integer)
			Gap open cost for protein

		protein_gap_ext (Integer)
			Gap extension cost for protein

		dna_gap_open (Integer)
			Gap open cost for dna

		dna_gap_ext (Integer)
			Gap extension cost for dna

		gnuplot_call (String)

		gnuplot_commands (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/combat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::combat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $combat = Bio::Tools::Run::PiseApplication::combat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::combat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $combat = $factory->program('combat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::combat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/combat.pm

    $self->{COMMAND}   = "combat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "COMBAT";

    $self->{DESCRIPTION}   = "Comparison of coding DNA";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Pedersen, Lyngso,Hein";

    $self->{REFERENCE}   = [

         "Christian N. S. Pedersen, Rune B. Lyngso and Jotun Hein. Comparison of coding DNA in Proceedings of the 9th Annual Symposium of Combinatorial Pattern Matching (CPM), 1998.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"combat",
	"sequence1",
	"sequence2",
	"output_aln",
	"alignment_file",
	"protein_distance_matrix",
	"nucleotide_distance_matrix",
	"protein_gap_open",
	"protein_gap_ext",
	"dna_gap_open",
	"dna_gap_ext",
	"results_files",
	"gnuplot_call",
	"gnuplot_commands",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"combat",
	"sequence1", 	# First Sequence
	"sequence2", 	# Second Sequence
	"output_aln",
	"alignment_file",
	"protein_distance_matrix", 	# Amino-acid distance matrix
	"nucleotide_distance_matrix", 	# Nucleotid distance matrix
	"protein_gap_open", 	# Gap open cost for protein
	"protein_gap_ext", 	# Gap extension cost for protein
	"dna_gap_open", 	# Gap open cost for dna
	"dna_gap_ext", 	# Gap extension cost for dna
	"results_files",
	"gnuplot_call",
	"gnuplot_commands",

    ];

    $self->{TYPE}  = {
	"combat" => 'String',
	"sequence1" => 'Sequence',
	"sequence2" => 'Sequence',
	"output_aln" => 'OutFile',
	"alignment_file" => 'OutFile',
	"protein_distance_matrix" => 'Excl',
	"nucleotide_distance_matrix" => 'Excl',
	"protein_gap_open" => 'Integer',
	"protein_gap_ext" => 'Integer',
	"dna_gap_open" => 'Integer',
	"dna_gap_ext" => 'Integer',
	"results_files" => 'Results',
	"gnuplot_call" => 'String',
	"gnuplot_commands" => 'String',

    };

    $self->{FORMAT}  = {
	"combat" => {
		"perl" => '"cat $sequence2 >> $sequence1; combat control_file > distance.out ; combat_combine $sequence1 combat.aln"',
	},
	"sequence1" => {
		"perl" => '">inputfile\n\"$value\"\n"',
	},
	"sequence2" => {
		"perl" => '""',
	},
	"output_aln" => {
		"perl" => '">outputfile\n\"combat.aln\"\n"',
	},
	"alignment_file" => {
		"perl" => '""',
	},
	"protein_distance_matrix" => {
		"perl" => '">distance matrix\n\"/local/gensoft/lib/combat/$value" . "_distance.m\"\n"',
	},
	"nucleotide_distance_matrix" => {
		"perl" => '">nucleotide matrix\n\"/local/gensoft/lib/combat/nucleotide_distance$value.m\"\n"',
	},
	"protein_gap_open" => {
		"perl" => '">gap functions\\nprotein:        $value"',
	},
	"protein_gap_ext" => {
		"perl" => '" + $value*k\\n"',
	},
	"dna_gap_open" => {
		"perl" => '"dna:        $value"',
	},
	"dna_gap_ext" => {
		"perl" => '" + $value*k"',
	},
	"results_files" => {
	},
	"gnuplot_call" => {
		"perl" => '"; gnuplot < gnuplot_file"',
	},
	"gnuplot_commands" => {
		"perl" => '"set xtics 12,5.,1000\nset ytics 12,5.,1000\nset grid\nset terminal postscript\nset output \"combat.ps\"\nplot \"combat.aln\" with lines\n"',
	},

    };

    $self->{FILENAMES}  = {
	"results_files" => 'control_file gnuplot_file combat.ps distance.out',

    };

    $self->{SEQFMT}  = {
	"sequence1" => [8],
	"sequence2" => [8],

    };

    $self->{GROUP}  = {
	"combat" => 0,
	"sequence1" => 1,
	"sequence2" => 0,
	"output_aln" => 2,
	"alignment_file" => 0,
	"protein_distance_matrix" => 3,
	"nucleotide_distance_matrix" => 4,
	"protein_gap_open" => 5,
	"protein_gap_ext" => 6,
	"dna_gap_open" => 7,
	"dna_gap_ext" => 8,
	"gnuplot_call" => 100,
	"gnuplot_commands" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"combat",
	"sequence2",
	"alignment_file",
	"results_files",
	"sequence1",
	"gnuplot_commands",
	"output_aln",
	"protein_distance_matrix",
	"nucleotide_distance_matrix",
	"protein_gap_open",
	"protein_gap_ext",
	"dna_gap_open",
	"dna_gap_ext",
	"gnuplot_call",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"combat" => 1,
	"sequence1" => 0,
	"sequence2" => 0,
	"output_aln" => 1,
	"alignment_file" => 1,
	"protein_distance_matrix" => 0,
	"nucleotide_distance_matrix" => 0,
	"protein_gap_open" => 0,
	"protein_gap_ext" => 0,
	"dna_gap_open" => 0,
	"dna_gap_ext" => 0,
	"results_files" => 0,
	"gnuplot_call" => 1,
	"gnuplot_commands" => 1,

    };

    $self->{ISCOMMAND}  = {
	"combat" => 1,
	"sequence1" => 0,
	"sequence2" => 0,
	"output_aln" => 0,
	"alignment_file" => 0,
	"protein_distance_matrix" => 0,
	"nucleotide_distance_matrix" => 0,
	"protein_gap_open" => 0,
	"protein_gap_ext" => 0,
	"dna_gap_open" => 0,
	"dna_gap_ext" => 0,
	"results_files" => 0,
	"gnuplot_call" => 0,
	"gnuplot_commands" => 0,

    };

    $self->{ISMANDATORY}  = {
	"combat" => 0,
	"sequence1" => 1,
	"sequence2" => 1,
	"output_aln" => 0,
	"alignment_file" => 0,
	"protein_distance_matrix" => 1,
	"nucleotide_distance_matrix" => 1,
	"protein_gap_open" => 1,
	"protein_gap_ext" => 1,
	"dna_gap_open" => 1,
	"dna_gap_ext" => 1,
	"results_files" => 0,
	"gnuplot_call" => 0,
	"gnuplot_commands" => 0,

    };

    $self->{PROMPT}  = {
	"combat" => "",
	"sequence1" => "First Sequence",
	"sequence2" => "Second Sequence",
	"output_aln" => "",
	"alignment_file" => "",
	"protein_distance_matrix" => "Amino-acid distance matrix",
	"nucleotide_distance_matrix" => "Nucleotid distance matrix",
	"protein_gap_open" => "Gap open cost for protein",
	"protein_gap_ext" => "Gap extension cost for protein",
	"dna_gap_open" => "Gap open cost for dna",
	"dna_gap_ext" => "Gap extension cost for dna",
	"results_files" => "",
	"gnuplot_call" => "",
	"gnuplot_commands" => "",

    };

    $self->{ISSTANDOUT}  = {
	"combat" => 0,
	"sequence1" => 0,
	"sequence2" => 0,
	"output_aln" => 0,
	"alignment_file" => 1,
	"protein_distance_matrix" => 0,
	"nucleotide_distance_matrix" => 0,
	"protein_gap_open" => 0,
	"protein_gap_ext" => 0,
	"dna_gap_open" => 0,
	"dna_gap_ext" => 0,
	"results_files" => 0,
	"gnuplot_call" => 0,
	"gnuplot_commands" => 0,

    };

    $self->{VLIST}  = {

	"protein_distance_matrix" => ['PAM60','PAM60','PAM120','PAM120','PAM250','PAM250','PAM350','PAM350','Blosum30','Blosum30','Blosum62','Blosum62','Blosum90','Blosum90',],
	"nucleotide_distance_matrix" => ['1','matrix 1','2','matrix 2','3','matrix 3',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"output_aln" => '"combat.aln"',
	"alignment_file" => '"combat.out"',
	"protein_distance_matrix" => 'PAM60',
	"nucleotide_distance_matrix" => '1',
	"protein_gap_open" => '20',
	"protein_gap_ext" => '8',
	"dna_gap_open" => '8',
	"dna_gap_ext" => '2',

    };

    $self->{PRECOND}  = {
	"combat" => { "perl" => '1' },
	"sequence1" => { "perl" => '1' },
	"sequence2" => { "perl" => '1' },
	"output_aln" => { "perl" => '1' },
	"alignment_file" => { "perl" => '1' },
	"protein_distance_matrix" => { "perl" => '1' },
	"nucleotide_distance_matrix" => { "perl" => '1' },
	"protein_gap_open" => { "perl" => '1' },
	"protein_gap_ext" => { "perl" => '1' },
	"dna_gap_open" => { "perl" => '1' },
	"dna_gap_ext" => { "perl" => '1' },
	"results_files" => { "perl" => '1' },
	"gnuplot_call" => { "perl" => '1' },
	"gnuplot_commands" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"alignment_file" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"combat" => 0,
	"sequence1" => 0,
	"sequence2" => 0,
	"output_aln" => 0,
	"alignment_file" => 0,
	"protein_distance_matrix" => 0,
	"nucleotide_distance_matrix" => 0,
	"protein_gap_open" => 0,
	"protein_gap_ext" => 0,
	"dna_gap_open" => 0,
	"dna_gap_ext" => 0,
	"results_files" => 0,
	"gnuplot_call" => 0,
	"gnuplot_commands" => 0,

    };

    $self->{ISSIMPLE}  = {
	"combat" => 0,
	"sequence1" => 1,
	"sequence2" => 1,
	"output_aln" => 0,
	"alignment_file" => 0,
	"protein_distance_matrix" => 0,
	"nucleotide_distance_matrix" => 0,
	"protein_gap_open" => 1,
	"protein_gap_ext" => 1,
	"dna_gap_open" => 1,
	"dna_gap_ext" => 1,
	"results_files" => 0,
	"gnuplot_call" => 0,
	"gnuplot_commands" => 0,

    };

    $self->{PARAMFILE}  = {
	"sequence1" => "control_file",
	"output_aln" => "control_file",
	"protein_distance_matrix" => "control_file",
	"nucleotide_distance_matrix" => "control_file",
	"protein_gap_open" => "control_file",
	"protein_gap_ext" => "control_file",
	"dna_gap_open" => "control_file",
	"dna_gap_ext" => "control_file",
	"gnuplot_commands" => "gnuplot_file",

    };

    $self->{COMMENT}  = {
	"sequence1" => [
		" Each of the two sequences must describe an integer number ofcodon, i.e. the length of each sequence must be a multiple of three.",
	],
	"sequence2" => [
		" Each of the two sequences must describe an integer number ofcodon, i.e. the length of each sequence must be a multiple of three.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/combat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

