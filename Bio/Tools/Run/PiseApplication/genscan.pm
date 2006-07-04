# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::genscan
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::genscan

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::genscan

      Bioperl class for:

	GENSCAN	Gene Identification (C. Burge)

	References:

		Burge, C., Karlin, S. (1997) Prediction of complete gene structures in human genomic DNA. J. Mol. Biol. 268, 78-94.

		Burge, C., Karlin, S. (1997) Gene structure, exon prediction, and alternative splicing.  (in preparation).

		Burge, C. (1997) Identification of genes in human genomic DNA. PhD thesis, Stanford University, Stanford, CA.

		Burset, M., Guigo, R. (1996) Evaluation of gene structure prediction programs.  Genomics 34, 353-367.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/genscan.html 
         for available values):


		genscan (String)

		seq (Sequence)
			DNA Sequence File
			pipe: seqfile

		parameter_file (Excl)
			Parameter file

		verbose (Switch)
			Verbose output (-v)

		cds (Switch)
			Print predicted coding sequences (-cds)

		subopt (Switch)
			Identify suboptimal exons (-subopt)

		cutoff (Integer)
			Cutoff for suboptimal exons

		ps (Switch)
			Create Postscript output (-ps)

		scale (Integer)
			Scale for PostScript output (bp per line)

		psfname (OutFile)
			Filename for PostScript output

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

http://bioweb.pasteur.fr/seqanal/interfaces/genscan.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::genscan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $genscan = Bio::Tools::Run::PiseApplication::genscan->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::genscan object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $genscan = $factory->program('genscan');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::genscan.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/genscan.pm

    $self->{COMMAND}   = "genscan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "GENSCAN";

    $self->{DESCRIPTION}   = "Gene Identification";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "C. Burge";

    $self->{REFERENCE}   = [

         "Burge, C., Karlin, S. (1997) Prediction of complete gene structures in human genomic DNA. J. Mol. Biol. 268, 78-94.",

         "Burge, C., Karlin, S. (1997) Gene structure, exon prediction, and alternative splicing.  (in preparation).",

         "Burge, C. (1997) Identification of genes in human genomic DNA. PhD thesis, Stanford University, Stanford, CA.",

         "Burset, M., Guigo, R. (1996) Evaluation of gene structure prediction programs.  Genomics 34, 353-367.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"genscan",
	"seq",
	"parameter_file",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"genscan",
	"seq", 	# DNA Sequence File
	"parameter_file", 	# Parameter file
	"output", 	# Output parameters
	"verbose", 	# Verbose output (-v)
	"cds", 	# Print predicted coding sequences (-cds)
	"subopt", 	# Identify suboptimal exons (-subopt)
	"cutoff", 	# Cutoff for suboptimal exons
	"ps", 	# Create Postscript output (-ps)
	"scale", 	# Scale for PostScript output (bp per line)
	"psfname", 	# Filename for PostScript output

    ];

    $self->{TYPE}  = {
	"genscan" => 'String',
	"seq" => 'Sequence',
	"parameter_file" => 'Excl',
	"output" => 'Paragraph',
	"verbose" => 'Switch',
	"cds" => 'Switch',
	"subopt" => 'Switch',
	"cutoff" => 'Integer',
	"ps" => 'Switch',
	"scale" => 'Integer',
	"psfname" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"genscan" => {
		"seqlab" => 'genscan',
		"perl" => '"genscan"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"parameter_file" => {
		"perl" => '" $value"',
	},
	"output" => {
	},
	"verbose" => {
		"perl" => ' ($value)? " -v":""',
	},
	"cds" => {
		"perl" => ' ($value)? " -cds":""',
	},
	"subopt" => {
		"perl" => ' ($value)? " -subopt $cutoff":""',
	},
	"cutoff" => {
		"perl" => ' "" ',
	},
	"ps" => {
		"perl" => ' ($value)? " -ps $psfname $scale" : "" ',
	},
	"scale" => {
		"perl" => '"" ',
	},
	"psfname" => {
		"perl" => '"" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"genscan" => 0,
	"seq" => 2,
	"parameter_file" => 1,
	"output" => 3,
	"verbose" => 3,
	"cds" => 3,
	"subopt" => 3,
	"cutoff" => 3,
	"ps" => 3,
	"scale" => 3,
	"psfname" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"genscan",
	"parameter_file",
	"seq",
	"output",
	"verbose",
	"cds",
	"subopt",
	"cutoff",
	"ps",
	"scale",
	"psfname",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"genscan" => 1,
	"seq" => 0,
	"parameter_file" => 0,
	"output" => 0,
	"verbose" => 0,
	"cds" => 0,
	"subopt" => 0,
	"cutoff" => 0,
	"ps" => 0,
	"scale" => 0,
	"psfname" => 0,

    };

    $self->{ISCOMMAND}  = {
	"genscan" => 1,
	"seq" => 0,
	"parameter_file" => 0,
	"output" => 0,
	"verbose" => 0,
	"cds" => 0,
	"subopt" => 0,
	"cutoff" => 0,
	"ps" => 0,
	"scale" => 0,
	"psfname" => 0,

    };

    $self->{ISMANDATORY}  = {
	"genscan" => 0,
	"seq" => 1,
	"parameter_file" => 1,
	"output" => 0,
	"verbose" => 0,
	"cds" => 0,
	"subopt" => 0,
	"cutoff" => 0,
	"ps" => 0,
	"scale" => 0,
	"psfname" => 1,

    };

    $self->{PROMPT}  = {
	"genscan" => "",
	"seq" => "DNA Sequence File",
	"parameter_file" => "Parameter file",
	"output" => "Output parameters",
	"verbose" => "Verbose output (-v)",
	"cds" => "Print predicted coding sequences (-cds)",
	"subopt" => "Identify suboptimal exons (-subopt)",
	"cutoff" => "Cutoff for suboptimal exons",
	"ps" => "Create Postscript output (-ps)",
	"scale" => "Scale for PostScript output (bp per line)",
	"psfname" => "Filename for PostScript output",

    };

    $self->{ISSTANDOUT}  = {
	"genscan" => 0,
	"seq" => 0,
	"parameter_file" => 0,
	"output" => 0,
	"verbose" => 0,
	"cds" => 0,
	"subopt" => 0,
	"cutoff" => 0,
	"ps" => 0,
	"scale" => 0,
	"psfname" => 0,

    };

    $self->{VLIST}  = {

	"parameter_file" => ['Arabidopsis.smat','Arabidopsis','HumanIso.smat','HumanIso','Maize.smat','Maize',],
	"output" => ['verbose','cds','subopt','cutoff','ps','scale','psfname',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"verbose" => '0',
	"cds" => '0',
	"subopt" => '0',
	"ps" => '0',
	"psfname" => 'genscan.ps',

    };

    $self->{PRECOND}  = {
	"genscan" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"parameter_file" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"cds" => { "perl" => '1' },
	"subopt" => { "perl" => '1' },
	"cutoff" => {
		"perl" => '$subopt',
	},
	"ps" => { "perl" => '1' },
	"scale" => {
		"perl" => '$ps',
	},
	"psfname" => {
		"perl" => '$ps',
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
	"genscan" => 0,
	"seq" => 0,
	"parameter_file" => 0,
	"output" => 0,
	"verbose" => 0,
	"cds" => 0,
	"subopt" => 0,
	"cutoff" => 0,
	"ps" => 0,
	"scale" => 0,
	"psfname" => 0,

    };

    $self->{ISSIMPLE}  = {
	"genscan" => 1,
	"seq" => 1,
	"parameter_file" => 1,
	"output" => 0,
	"verbose" => 0,
	"cds" => 0,
	"subopt" => 0,
	"cutoff" => 0,
	"ps" => 0,
	"scale" => 0,
	"psfname" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"parameter_file" => [
		"Currently available parameter files are:",
		"HumanIso.smat for human/vertebrate sequences (also Drosophila)",
		"Arabidopsis.smat for Arabidopsis thaliana sequences",
		"Maize.smat for Zea mays sequences",
	],
	"verbose" => [
		"Add some extra explanatory information to the text output. This information may be helpful the first few times you run the program but will soon become tiresome (that\'s why its optional).",
	],
	"subopt" => [
		"The default output of the program is the optimal \'parse\' of the sequence, i.e. the highest probability gene structure(s) which is present: the exons in this optimal parse are referred to as \'optimal exons\' and are always printed out by GENSCAN. Suboptimal exons, on the other hand, are defined as potential exons which have probability above a certian threshold but which are not contained in the optimal parse of the sequence. Suboptimal exons have a variety of potential uses. First, suboptimal exons sometimes correspond to real exons which were missed for whatever reason by the optimal parse of the sequence. Second, regions of a prediction which contain multiple overlapping and/or incompatible optimal and suboptimal exons may in some cases indicate alternatively spliced regions of a gene (Burge & Karlin, in preparation).",
	],
	"cutoff" => [
		"The cutoff is the probability cutoff used to determine which potential exons qualify as suboptimal exons. This argument should be a number between 0.01 and 0.99. For most applications, a cutoff value of about 0.10 is recommended. Setting the value much lower than 0.10 will often lead to an explosion in the number of suboptimal exons, most of which will probably not be useful. On the other hand, if the value is set much higher than 0.10, then potentially interesting suboptimal exons may be missed.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/genscan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

