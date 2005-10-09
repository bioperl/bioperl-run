# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::toppred
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::toppred

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::toppred

      Bioperl class for:

	TopPred	Topology prediction of membrane proteins (Heijne, Wallin, Claros, Deveaud, Schuerer )

	References:

		von Heijne, G. (1992) Membrane Protein Structure Prediction: Hydrophobicity Analysis and the 'Positive Inside' Rule. J.Mol.Biol. 225, 487-494.

		Claros, M.G., and von Heijne, G. (1994) TopPred II: An Improved Software For Membrane Protein Structure Predictions. CABIOS 10, 685-686.

		Deveaud and Schuerer (Pasteur Institute) new implementation of the original toppred program, based on G. von Heijne algorithm.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/toppred.html 
         for available values):


		toppred (String)

		query (Sequence)
			Sequence

		graph_output (Switch)
			Produce hydrophobicity graph image (-g)

		topo_output (Switch)
			Produce image of each topology (-t)

		scale (Excl)
			Hydrophobicity scale (-H)

		organism (Switch)
			Organism: eukaryot (default is prokaryot) (-e)

		certain (Float)
			Upper cutoff (-c)

		putative (Float)
			Lower cutoff (-p)

		core (Integer)
			Core window size:  (-n)

		triangle (Integer)
			Wedge window size: (-q)

		loop_length (Integer)
			Critical loop length (-s)

		Segment_distance (Integer)
			Critical transmembrane spacer (-d)

		outformat (Excl)
			Output format (-O)

		profile_format (Excl)
			Hydrophobicity Profile file format

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/toppred.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::toppred;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $toppred = Bio::Tools::Run::PiseApplication::toppred->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::toppred object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $toppred = $factory->program('toppred');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::toppred.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/toppred.pm

    $self->{COMMAND}   = "toppred";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TopPred";

    $self->{DESCRIPTION}   = "Topology prediction of membrane proteins";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Heijne, Wallin, Claros, Deveaud, Schuerer ";

    $self->{REFERENCE}   = [

         "von Heijne, G. (1992) Membrane Protein Structure Prediction: Hydrophobicity Analysis and the 'Positive Inside' Rule. J.Mol.Biol. 225, 487-494.",

         "Claros, M.G., and von Heijne, G. (1994) TopPred II: An Improved Software For Membrane Protein Structure Predictions. CABIOS 10, 685-686.",

         "Deveaud and Schuerer (Pasteur Institute) new implementation of the original toppred program, based on G. von Heijne algorithm.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"toppred",
	"query",
	"graph_output",
	"topo_output",
	"control",
	"output_options",
	"graphicfiles",
	"outputfiles",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"toppred",
	"query", 	# Sequence
	"graph_output", 	# Produce hydrophobicity graph image (-g)
	"topo_output", 	# Produce image of each topology (-t)
	"control", 	# Control options
	"scale", 	# Hydrophobicity scale (-H)
	"organism", 	# Organism: eukaryot (default is prokaryot) (-e)
	"certain", 	# Upper cutoff (-c)
	"putative", 	# Lower cutoff (-p)
	"core", 	# Core window size:  (-n)
	"triangle", 	# Wedge window size: (-q)
	"loop_length", 	# Critical loop length (-s)
	"Segment_distance", 	# Critical transmembrane spacer (-d)
	"output_options", 	# Output options
	"outformat", 	# Output format (-O)
	"profile_format", 	# Hydrophobicity Profile file format
	"graphicfiles",
	"outputfiles",

    ];

    $self->{TYPE}  = {
	"toppred" => 'String',
	"query" => 'Sequence',
	"graph_output" => 'Switch',
	"topo_output" => 'Switch',
	"control" => 'Paragraph',
	"scale" => 'Excl',
	"organism" => 'Switch',
	"certain" => 'Float',
	"putative" => 'Float',
	"core" => 'Integer',
	"triangle" => 'Integer',
	"loop_length" => 'Integer',
	"Segment_distance" => 'Integer',
	"output_options" => 'Paragraph',
	"outformat" => 'Excl',
	"profile_format" => 'Excl',
	"graphicfiles" => 'Results',
	"outputfiles" => 'Results',

    };

    $self->{FORMAT}  = {
	"toppred" => {
		"perl" => '"toppred"',
	},
	"query" => {
		"perl" => '" $value"',
	},
	"graph_output" => {
	},
	"topo_output" => {
		"perl" => '($value) ? "" : " -t none"',
	},
	"control" => {
	},
	"scale" => {
		"perl" => '($value) ? " -H $value" : ""',
	},
	"organism" => {
		"perl" => '($value)? " -e " : ""',
	},
	"certain" => {
		"perl" => '($value && $value != $vdef)? " -c $value" : ""',
	},
	"putative" => {
		"perl" => '($value && $value != $vdef)? " -p $value" : ""',
	},
	"core" => {
		"perl" => '($value && $value != $vdef)? " -n $value" : ""',
	},
	"triangle" => {
		"perl" => '($value && $value != $vdef)? " -q $value" : ""',
	},
	"loop_length" => {
		"perl" => '($value && $value != $vdef)? " -s $value" :"" ',
	},
	"Segment_distance" => {
		"perl" => '($value && $value != $vdef)? " -d $value" :"" ',
	},
	"output_options" => {
	},
	"outformat" => {
		"perl" => '($value && $value ne $vdef) ? " -O $value" : ""',
	},
	"profile_format" => {
		"perl" => '($graph_output) ?  " -g $value" : " -g none" ',
	},
	"graphicfiles" => {
	},
	"outputfiles" => {
	},

    };

    $self->{FILENAMES}  = {
	"graphicfiles" => '*.ps *.ppm *.png *.html',
	"outputfiles" => '*.hydro*',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"toppred" => 0,
	"query" => 10,
	"topo_output" => 7,
	"scale" => 1,
	"organism" => 1,
	"certain" => 2,
	"putative" => 2,
	"core" => 2,
	"triangle" => 2,
	"loop_length" => 2,
	"Segment_distance" => 2,
	"outformat" => 5,
	"profile_format" => 7,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"toppred",
	"graphicfiles",
	"graph_output",
	"output_options",
	"control",
	"outputfiles",
	"organism",
	"scale",
	"putative",
	"core",
	"triangle",
	"loop_length",
	"Segment_distance",
	"certain",
	"outformat",
	"profile_format",
	"topo_output",
	"query",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"toppred" => 1,
	"query" => 0,
	"graph_output" => 0,
	"topo_output" => 0,
	"control" => 0,
	"scale" => 0,
	"organism" => 0,
	"certain" => 0,
	"putative" => 0,
	"core" => 0,
	"triangle" => 0,
	"loop_length" => 0,
	"Segment_distance" => 0,
	"output_options" => 0,
	"outformat" => 0,
	"profile_format" => 0,
	"graphicfiles" => 1,
	"outputfiles" => 1,

    };

    $self->{ISCOMMAND}  = {
	"toppred" => 1,
	"query" => 0,
	"graph_output" => 0,
	"topo_output" => 0,
	"control" => 0,
	"scale" => 0,
	"organism" => 0,
	"certain" => 0,
	"putative" => 0,
	"core" => 0,
	"triangle" => 0,
	"loop_length" => 0,
	"Segment_distance" => 0,
	"output_options" => 0,
	"outformat" => 0,
	"profile_format" => 0,
	"graphicfiles" => 0,
	"outputfiles" => 0,

    };

    $self->{ISMANDATORY}  = {
	"toppred" => 0,
	"query" => 1,
	"graph_output" => 0,
	"topo_output" => 0,
	"control" => 0,
	"scale" => 0,
	"organism" => 0,
	"certain" => 0,
	"putative" => 0,
	"core" => 0,
	"triangle" => 0,
	"loop_length" => 0,
	"Segment_distance" => 0,
	"output_options" => 0,
	"outformat" => 0,
	"profile_format" => 0,
	"graphicfiles" => 0,
	"outputfiles" => 0,

    };

    $self->{PROMPT}  = {
	"toppred" => "",
	"query" => "Sequence",
	"graph_output" => "Produce hydrophobicity graph image (-g)",
	"topo_output" => "Produce image of each topology (-t)",
	"control" => "Control options",
	"scale" => "Hydrophobicity scale (-H)",
	"organism" => "Organism: eukaryot (default is prokaryot) (-e)",
	"certain" => "Upper cutoff (-c)",
	"putative" => "Lower cutoff (-p)",
	"core" => "Core window size:  (-n)",
	"triangle" => "Wedge window size: (-q)",
	"loop_length" => "Critical loop length (-s)",
	"Segment_distance" => "Critical transmembrane spacer (-d)",
	"output_options" => "Output options",
	"outformat" => "Output format (-O)",
	"profile_format" => "Hydrophobicity Profile file format",
	"graphicfiles" => "",
	"outputfiles" => "",

    };

    $self->{ISSTANDOUT}  = {
	"toppred" => 0,
	"query" => 0,
	"graph_output" => 0,
	"topo_output" => 0,
	"control" => 0,
	"scale" => 0,
	"organism" => 0,
	"certain" => 0,
	"putative" => 0,
	"core" => 0,
	"triangle" => 0,
	"loop_length" => 0,
	"Segment_distance" => 0,
	"output_options" => 0,
	"outformat" => 0,
	"profile_format" => 0,
	"graphicfiles" => 0,
	"outputfiles" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['scale','organism','certain','putative','core','triangle','loop_length','Segment_distance',],
	"scale" => ['KD-scale','KD-scale (Kyte and Doolittle)','GVH-scale','GVH-scale (Gunnar von Heijne)','GES-scale','GES-scale (Goldman Engelman Steitz)',],
	"output_options" => ['outformat','profile_format',],
	"outformat" => ['new','New: new text output format','html','HTML','old','Old : output format of the old toppred implementation','xml','Xml',],
	"profile_format" => ['png','PNG output','ps','PostScript output','ppm','PPM output',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"graph_output" => '1',
	"topo_output" => '0',
	"scale" => 'GES-scale',
	"certain" => '1.0',
	"putative" => '0.6',
	"core" => '10',
	"triangle" => '5',
	"loop_length" => '60',
	"Segment_distance" => '2',
	"outformat" => 'new',
	"profile_format" => 'png',

    };

    $self->{PRECOND}  = {
	"toppred" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"graph_output" => { "perl" => '1' },
	"topo_output" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"organism" => { "perl" => '1' },
	"certain" => { "perl" => '1' },
	"putative" => { "perl" => '1' },
	"core" => { "perl" => '1' },
	"triangle" => { "perl" => '1' },
	"loop_length" => { "perl" => '1' },
	"Segment_distance" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },
	"profile_format" => { "perl" => '1' },
	"graphicfiles" => { "perl" => '1' },
	"outputfiles" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"toppred" => 0,
	"query" => 0,
	"graph_output" => 0,
	"topo_output" => 0,
	"control" => 0,
	"scale" => 0,
	"organism" => 0,
	"certain" => 0,
	"putative" => 0,
	"core" => 0,
	"triangle" => 0,
	"loop_length" => 0,
	"Segment_distance" => 0,
	"output_options" => 0,
	"outformat" => 0,
	"profile_format" => 0,
	"graphicfiles" => 0,
	"outputfiles" => 0,

    };

    $self->{ISSIMPLE}  = {
	"toppred" => 1,
	"query" => 1,
	"graph_output" => 1,
	"topo_output" => 1,
	"control" => 0,
	"scale" => 0,
	"organism" => 0,
	"certain" => 0,
	"putative" => 0,
	"core" => 0,
	"triangle" => 0,
	"loop_length" => 0,
	"Segment_distance" => 0,
	"output_options" => 0,
	"outformat" => 0,
	"profile_format" => 0,
	"graphicfiles" => 0,
	"outputfiles" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/toppred.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

