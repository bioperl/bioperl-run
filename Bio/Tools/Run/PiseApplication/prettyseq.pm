# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::prettyseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::prettyseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prettyseq

      Bioperl class for:

	PRETTYSEQ	Output sequence with translated ranges (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/prettyseq.html 
         for available values):


		prettyseq (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [single sequence] (-sequence)
			pipe: seqfile

		range (Integer)
			Range(s) to translate (-range)

		cfile (Excl)
			Codon usage file (-cfile)

		width (Integer)
			Width of screen (-width)

		ruler (Switch)
			Add a ruler (-ruler)

		plabel (Switch)
			Number translations (-plabel)

		nlabel (Switch)
			Number DNA sequence (-nlabel)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/prettyseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::prettyseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prettyseq = Bio::Tools::Run::PiseApplication::prettyseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prettyseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $prettyseq = $factory->program('prettyseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::prettyseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prettyseq.pm

    $self->{COMMAND}   = "prettyseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PRETTYSEQ";

    $self->{DESCRIPTION}   = "Output sequence with translated ranges (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",

         "nucleic:translation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/prettyseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prettyseq",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prettyseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [single sequence] (-sequence)
	"required", 	# required Section
	"range", 	# Range(s) to translate (-range)
	"advanced", 	# advanced Section
	"cfile", 	# Codon usage file (-cfile)
	"width", 	# Width of screen (-width)
	"ruler", 	# Add a ruler (-ruler)
	"plabel", 	# Number translations (-plabel)
	"nlabel", 	# Number DNA sequence (-nlabel)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"prettyseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"range" => 'Integer',
	"advanced" => 'Paragraph',
	"cfile" => 'Excl',
	"width" => 'Integer',
	"ruler" => 'Switch',
	"plabel" => 'Switch',
	"nlabel" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"range" => {
		"perl" => '" -range=$value"',
	},
	"advanced" => {
	},
	"cfile" => {
		"perl" => '($value && $value ne $vdef)? " -cfile=$value" : ""',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"ruler" => {
		"perl" => '($value)? "" : " -noruler"',
	},
	"plabel" => {
		"perl" => '($value)? "" : " -noplabel"',
	},
	"nlabel" => {
		"perl" => '($value)? "" : " -nonlabel"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"prettyseq" => {
		"perl" => '"prettyseq"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"range" => 2,
	"cfile" => 3,
	"width" => 4,
	"ruler" => 5,
	"plabel" => 6,
	"nlabel" => 7,
	"outfile" => 8,
	"auto" => 9,
	"prettyseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"prettyseq",
	"sequence",
	"range",
	"cfile",
	"width",
	"ruler",
	"plabel",
	"nlabel",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"range" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"width" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"prettyseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"range" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"width" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"range" => 1,
	"advanced" => 0,
	"cfile" => 0,
	"width" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [single sequence] (-sequence)",
	"required" => "required Section",
	"range" => "Range(s) to translate (-range)",
	"advanced" => "advanced Section",
	"cfile" => "Codon usage file (-cfile)",
	"width" => "Width of screen (-width)",
	"ruler" => "Add a ruler (-ruler)",
	"plabel" => "Number translations (-plabel)",
	"nlabel" => "Number DNA sequence (-nlabel)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"range" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"width" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['range',],
	"advanced" => ['cfile','width','ruler','plabel','nlabel',],
	"cfile" => ['Ebmo.cut','Ebmo.cut','Etom.cut','Etom.cut','Erat.cut','Erat.cut','Ebsu.cut','Ebsu.cut','Echicken.cut','Echicken.cut','Etob.cut','Etob.cut','Echnt.cut','Echnt.cut','Eyscmt.cut','Eyscmt.cut','Ehin.cut','Ehin.cut','Echmp.cut','Echmp.cut','Ecal.cut','Ecal.cut','Evco.cut','Evco.cut','Epfa.cut','Epfa.cut','Esty.cut','Esty.cut','Echk.cut','Echk.cut','Eaidlav.cut','Eaidlav.cut','Esgi.cut','Esgi.cut','Emtu.cut','Emtu.cut','Ersp.cut','Ersp.cut','Esco.cut','Esco.cut','Ebna.cut','Ebna.cut','Ehuman.cut','Ehuman.cut','Eacc.cut','Eacc.cut','Eyeastcai.cut','Eyeastcai.cut','Eratsp.cut','Eratsp.cut','Ehma.cut','Ehma.cut','Erabbit.cut','Erabbit.cut','Erab.cut','Erab.cut','Emac.cut','Emac.cut','Eysc.cut','Eysc.cut','Emze.cut','Emze.cut','Espi.cut','Espi.cut','Epea.cut','Epea.cut','Ekla.cut','Ekla.cut','Eeca.cut','Eeca.cut','Echzmrubp.cut','Echzmrubp.cut','Eanidmit.cut','Eanidmit.cut','Esv40.cut','Esv40.cut','Epsy.cut','Epsy.cut','Eysc_h.cut','Eysc_h.cut','Eadenovirus5.cut','Eadenovirus5.cut','Espo_h.cut','Espo_h.cut','Eatu.cut','Eatu.cut','Eneu.cut','Eneu.cut','Epot.cut','Epot.cut','Edro_h.cut','Edro_h.cut','Ephix174.cut','Ephix174.cut','Epet.cut','Epet.cut','Ekpn.cut','Ekpn.cut','Ebme.cut','Ebme.cut','Ebovsp.cut','Ebovsp.cut','Esma.cut','Esma.cut','Etetsp.cut','Etetsp.cut','Ephy.cut','Ephy.cut','Exenopus.cut','Exenopus.cut','Eoncsp.cut','Eoncsp.cut','Exel.cut','Exel.cut','Esus.cut','Esus.cut','Eter.cut','Eter.cut','Epig.cut','Epig.cut','Erabsp.cut','Erabsp.cut','Espu.cut','Espu.cut','Ef1.cut','Ef1.cut','Erhm.cut','Erhm.cut','Emussp.cut','Emussp.cut','Engo.cut','Engo.cut','Emus.cut','Emus.cut','Eppu.cut','Eppu.cut','Ecre.cut','Ecre.cut','Esalsp.cut','Esalsp.cut','Easn.cut','Easn.cut','Esmi.cut','Esmi.cut','Eccr.cut','Eccr.cut','Emva.cut','Emva.cut','Esynsp.cut','Esynsp.cut','Espn.cut','Espn.cut','Etobcp.cut','Etobcp.cut','Ebja.cut','Ebja.cut','Ephv.cut','Ephv.cut','Echi.cut','Echi.cut','Efish.cut','Efish.cut','Epombecai.cut','Epombecai.cut','Eanasp.cut','Eanasp.cut','Eyen.cut','Eyen.cut','Ewht.cut','Ewht.cut','Ehum.cut','Ehum.cut','Etcr.cut','Etcr.cut','Emzecp.cut','Emzecp.cut','Esli.cut','Esli.cut','Ezebrafish.cut','Ezebrafish.cut','Emouse.cut','Emouse.cut','Esoy.cut','Esoy.cut','Eham.cut','Eham.cut','Esyhsp.cut','Esyhsp.cut','Eddi.cut','Eddi.cut','Emaize.cut','Emaize.cut','Emixlg.cut','Emixlg.cut','Eric.cut','Eric.cut','Esta.cut','Esta.cut','Eani.cut','Eani.cut','Epolyomaa2.cut','Epolyomaa2.cut','Ecac.cut','Ecac.cut','Eani_h.cut','Eani_h.cut','Echisp.cut','Echisp.cut','Ehha.cut','Ehha.cut','Ecel.cut','Ecel.cut','Encr.cut','Encr.cut','Epae.cut','Epae.cut','Eslm.cut','Eslm.cut','Ebsu_h.cut','Ebsu_h.cut','Eysp.cut','Eysp.cut','Echos.cut','Echos.cut','Etbr.cut','Etbr.cut','Edrosophila.cut','Edrosophila.cut','Erca.cut','Erca.cut','Ebov.cut','Ebov.cut','Eyeast.cut','Eyeast.cut','Emta.cut','Emta.cut','Epombe.cut','Epombe.cut','Esmu.cut','Esmu.cut','Etrb.cut','Etrb.cut','Ebst.cut','Ebst.cut','Erme.cut','Erme.cut','Eath.cut','Eath.cut','Efmdvpolyp.cut','Efmdvpolyp.cut','Ectr.cut','Ectr.cut','Emam_h.cut','Emam_h.cut','Eadenovirus7.cut','Eadenovirus7.cut','Ecpx.cut','Ecpx.cut','Eshpsp.cut','Eshpsp.cut','Espo.cut','Espo.cut','Emsa.cut','Emsa.cut','Eecoli.cut','Eecoli.cut','Edro.cut','Edro.cut','Ebly.cut','Ebly.cut','Eavi.cut','Eavi.cut','Epse.cut','Epse.cut','Epvu.cut','Epvu.cut','Eeco_h.cut','Eeco_h.cut','Erle.cut','Erle.cut','Ella.cut','Ella.cut','Edayhoff.cut','Edayhoff.cut','Eshp.cut','Eshp.cut','Emse.cut','Emse.cut','Ezma.cut','Ezma.cut','Eddi_h.cut','Eddi_h.cut','Esau.cut','Esau.cut','Echzm.cut','Echzm.cut','Edog.cut','Edog.cut','Ecrisp.cut','Ecrisp.cut','Eeco.cut','Eeco.cut',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"cfile" => 'Ehum.cut',
	"width" => '60',
	"ruler" => '1',
	"plabel" => '1',
	"nlabel" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"range" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"cfile" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"ruler" => { "perl" => '1' },
	"plabel" => { "perl" => '1' },
	"nlabel" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"range" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"width" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"range" => 1,
	"advanced" => 0,
	"cfile" => 0,
	"width" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prettyseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

