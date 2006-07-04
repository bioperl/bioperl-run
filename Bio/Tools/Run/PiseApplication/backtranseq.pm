# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::backtranseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::backtranseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::backtranseq

      Bioperl class for:

	BACKTRANSEQ	Back translate a protein sequence (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/backtranseq.html 
         for available values):


		backtranseq (String)

		init (String)

		sequence (Sequence)
			sequence -- GapProtein [single sequence] (-sequence)
			pipe: seqfile

		cfile (Excl)
			cfile [codon usage table name] (-cfile)

		outfile (OutFile)
			outfile (-outfile)
			pipe: seqfile

		outfile_sformat (Excl)
			Output format for: outfile

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

http://bioweb.pasteur.fr/seqanal/interfaces/backtranseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::backtranseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $backtranseq = Bio::Tools::Run::PiseApplication::backtranseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::backtranseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $backtranseq = $factory->program('backtranseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::backtranseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/backtranseq.pm

    $self->{COMMAND}   = "backtranseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BACKTRANSEQ";

    $self->{DESCRIPTION}   = "Back translate a protein sequence (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:translation",

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/backtranseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"backtranseq",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"backtranseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- GapProtein [single sequence] (-sequence)
	"advanced", 	# advanced Section
	"cfile", 	# cfile [codon usage table name] (-cfile)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"outfile_sformat", 	# Output format for: outfile
	"auto",

    ];

    $self->{TYPE}  = {
	"backtranseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"cfile" => 'Excl',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"outfile_sformat" => 'Excl',
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
	"advanced" => {
	},
	"cfile" => {
		"perl" => '($value)? " -cfile=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"outfile_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"backtranseq" => {
		"perl" => '"backtranseq"',
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
	"cfile" => 2,
	"outfile" => 3,
	"outfile_sformat" => 4,
	"auto" => 5,
	"backtranseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"backtranseq",
	"advanced",
	"output",
	"sequence",
	"cfile",
	"outfile",
	"outfile_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_sformat" => 0,
	"auto" => 1,
	"backtranseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 1,
	"outfile_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- GapProtein [single sequence] (-sequence)",
	"advanced" => "advanced Section",
	"cfile" => "cfile [codon usage table name] (-cfile)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"outfile_sformat" => "Output format for: outfile",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['cfile',],
	"cfile" => ['Ebmo.cut','Ebmo.cut','Etom.cut','Etom.cut','Erat.cut','Erat.cut','Ebsu.cut','Ebsu.cut','Echicken.cut','Echicken.cut','Etob.cut','Etob.cut','Echnt.cut','Echnt.cut','Eyscmt.cut','Eyscmt.cut','Ehin.cut','Ehin.cut','Echmp.cut','Echmp.cut','Ecal.cut','Ecal.cut','Evco.cut','Evco.cut','Epfa.cut','Epfa.cut','Esty.cut','Esty.cut','Echk.cut','Echk.cut','Eaidlav.cut','Eaidlav.cut','Esgi.cut','Esgi.cut','Emtu.cut','Emtu.cut','Ersp.cut','Ersp.cut','Esco.cut','Esco.cut','Ebna.cut','Ebna.cut','Ehuman.cut','Ehuman.cut','Eacc.cut','Eacc.cut','Eyeastcai.cut','Eyeastcai.cut','Eratsp.cut','Eratsp.cut','Ehma.cut','Ehma.cut','Erabbit.cut','Erabbit.cut','Erab.cut','Erab.cut','Emac.cut','Emac.cut','Eysc.cut','Eysc.cut','Emze.cut','Emze.cut','Espi.cut','Espi.cut','Epea.cut','Epea.cut','Ekla.cut','Ekla.cut','Eeca.cut','Eeca.cut','Echzmrubp.cut','Echzmrubp.cut','Eanidmit.cut','Eanidmit.cut','Esv40.cut','Esv40.cut','Epsy.cut','Epsy.cut','Eysc_h.cut','Eysc_h.cut','Eadenovirus5.cut','Eadenovirus5.cut','Espo_h.cut','Espo_h.cut','Eatu.cut','Eatu.cut','Eneu.cut','Eneu.cut','Epot.cut','Epot.cut','Edro_h.cut','Edro_h.cut','Ephix174.cut','Ephix174.cut','Epet.cut','Epet.cut','Ekpn.cut','Ekpn.cut','Ebme.cut','Ebme.cut','Ebovsp.cut','Ebovsp.cut','Esma.cut','Esma.cut','Etetsp.cut','Etetsp.cut','Ephy.cut','Ephy.cut','Exenopus.cut','Exenopus.cut','Eoncsp.cut','Eoncsp.cut','Exel.cut','Exel.cut','Esus.cut','Esus.cut','Eter.cut','Eter.cut','Epig.cut','Epig.cut','Erabsp.cut','Erabsp.cut','Espu.cut','Espu.cut','Ef1.cut','Ef1.cut','Erhm.cut','Erhm.cut','Emussp.cut','Emussp.cut','Engo.cut','Engo.cut','Emus.cut','Emus.cut','Eppu.cut','Eppu.cut','Ecre.cut','Ecre.cut','Esalsp.cut','Esalsp.cut','Easn.cut','Easn.cut','Esmi.cut','Esmi.cut','Eccr.cut','Eccr.cut','Emva.cut','Emva.cut','Esynsp.cut','Esynsp.cut','Espn.cut','Espn.cut','Etobcp.cut','Etobcp.cut','Ebja.cut','Ebja.cut','Ephv.cut','Ephv.cut','Echi.cut','Echi.cut','Efish.cut','Efish.cut','Epombecai.cut','Epombecai.cut','Eanasp.cut','Eanasp.cut','Eyen.cut','Eyen.cut','Ewht.cut','Ewht.cut','Ehum.cut','Ehum.cut','Etcr.cut','Etcr.cut','Emzecp.cut','Emzecp.cut','Esli.cut','Esli.cut','Ezebrafish.cut','Ezebrafish.cut','Emouse.cut','Emouse.cut','Esoy.cut','Esoy.cut','Eham.cut','Eham.cut','Esyhsp.cut','Esyhsp.cut','Eddi.cut','Eddi.cut','Emaize.cut','Emaize.cut','Emixlg.cut','Emixlg.cut','Eric.cut','Eric.cut','Esta.cut','Esta.cut','Eani.cut','Eani.cut','Epolyomaa2.cut','Epolyomaa2.cut','Ecac.cut','Ecac.cut','Eani_h.cut','Eani_h.cut','Echisp.cut','Echisp.cut','Ehha.cut','Ehha.cut','Ecel.cut','Ecel.cut','Encr.cut','Encr.cut','Epae.cut','Epae.cut','Eslm.cut','Eslm.cut','Ebsu_h.cut','Ebsu_h.cut','Eysp.cut','Eysp.cut','Echos.cut','Echos.cut','Etbr.cut','Etbr.cut','Edrosophila.cut','Edrosophila.cut','Erca.cut','Erca.cut','Ebov.cut','Ebov.cut','Eyeast.cut','Eyeast.cut','Emta.cut','Emta.cut','Epombe.cut','Epombe.cut','Esmu.cut','Esmu.cut','Etrb.cut','Etrb.cut','Ebst.cut','Ebst.cut','Erme.cut','Erme.cut','Eath.cut','Eath.cut','Efmdvpolyp.cut','Efmdvpolyp.cut','Ectr.cut','Ectr.cut','Emam_h.cut','Emam_h.cut','Eadenovirus7.cut','Eadenovirus7.cut','Ecpx.cut','Ecpx.cut','Eshpsp.cut','Eshpsp.cut','Espo.cut','Espo.cut','Emsa.cut','Emsa.cut','Eecoli.cut','Eecoli.cut','Edro.cut','Edro.cut','Ebly.cut','Ebly.cut','Eavi.cut','Eavi.cut','Epse.cut','Epse.cut','Epvu.cut','Epvu.cut','Eeco_h.cut','Eeco_h.cut','Erle.cut','Erle.cut','Ella.cut','Ella.cut','Edayhoff.cut','Edayhoff.cut','Eshp.cut','Eshp.cut','Emse.cut','Emse.cut','Ezma.cut','Ezma.cut','Eddi_h.cut','Eddi_h.cut','Esau.cut','Esau.cut','Echzm.cut','Echzm.cut','Edog.cut','Edog.cut','Ecrisp.cut','Ecrisp.cut','Eeco.cut','Eeco.cut',],
	"output" => ['outfile','outfile_sformat',],
	"outfile_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'outfile.out',
	"outfile_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"cfile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"outfile_sformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "seqfile",
	},

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
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 1,
	"outfile_sformat" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/backtranseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

