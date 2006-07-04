# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::codcmp
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::codcmp

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::codcmp

      Bioperl class for:

	CODCMP	Codon usage table comparison (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/codcmp.html 
         for available values):


		codcmp (String)

		init (String)

		first (Excl)
			First codon usage file (-first)

		second (Excl)
			Second codon usage file (-second)

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

http://bioweb.pasteur.fr/seqanal/interfaces/codcmp.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::codcmp;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $codcmp = Bio::Tools::Run::PiseApplication::codcmp->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::codcmp object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $codcmp = $factory->program('codcmp');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::codcmp.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codcmp.pm

    $self->{COMMAND}   = "codcmp";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CODCMP";

    $self->{DESCRIPTION}   = "Codon usage table comparison (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:codon usage",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/codcmp.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"codcmp",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"codcmp",
	"init",
	"input", 	# input Section
	"first", 	# First codon usage file (-first)
	"second", 	# Second codon usage file (-second)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"codcmp" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"first" => 'Excl',
	"second" => 'Excl',
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
	"first" => {
		"perl" => '" -first=$value"',
	},
	"second" => {
		"perl" => '" -second=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"codcmp" => {
		"perl" => '"codcmp"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"first" => 1,
	"second" => 2,
	"outfile" => 3,
	"auto" => 4,
	"codcmp" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"codcmp",
	"first",
	"second",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"first" => 0,
	"second" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"codcmp" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"first" => 0,
	"second" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"first" => 1,
	"second" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"first" => "First codon usage file (-first)",
	"second" => "Second codon usage file (-second)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"first" => 0,
	"second" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['first','second',],
	"first" => ['Ebmo.cut','Ebmo.cut','Etom.cut','Etom.cut','Erat.cut','Erat.cut','Ebsu.cut','Ebsu.cut','Echicken.cut','Echicken.cut','Etob.cut','Etob.cut','Echnt.cut','Echnt.cut','Eyscmt.cut','Eyscmt.cut','Ehin.cut','Ehin.cut','Echmp.cut','Echmp.cut','Ecal.cut','Ecal.cut','Evco.cut','Evco.cut','Epfa.cut','Epfa.cut','Esty.cut','Esty.cut','Echk.cut','Echk.cut','Eaidlav.cut','Eaidlav.cut','Esgi.cut','Esgi.cut','Emtu.cut','Emtu.cut','Ersp.cut','Ersp.cut','Esco.cut','Esco.cut','Ebna.cut','Ebna.cut','Ehuman.cut','Ehuman.cut','Eacc.cut','Eacc.cut','Eyeastcai.cut','Eyeastcai.cut','Eratsp.cut','Eratsp.cut','Ehma.cut','Ehma.cut','Erabbit.cut','Erabbit.cut','Erab.cut','Erab.cut','Emac.cut','Emac.cut','Eysc.cut','Eysc.cut','Emze.cut','Emze.cut','Espi.cut','Espi.cut','Epea.cut','Epea.cut','Ekla.cut','Ekla.cut','Eeca.cut','Eeca.cut','Echzmrubp.cut','Echzmrubp.cut','Eanidmit.cut','Eanidmit.cut','Esv40.cut','Esv40.cut','Epsy.cut','Epsy.cut','Eysc_h.cut','Eysc_h.cut','Eadenovirus5.cut','Eadenovirus5.cut','Espo_h.cut','Espo_h.cut','Eatu.cut','Eatu.cut','Eneu.cut','Eneu.cut','Epot.cut','Epot.cut','Edro_h.cut','Edro_h.cut','Ephix174.cut','Ephix174.cut','Epet.cut','Epet.cut','Ekpn.cut','Ekpn.cut','Ebme.cut','Ebme.cut','Ebovsp.cut','Ebovsp.cut','Esma.cut','Esma.cut','Etetsp.cut','Etetsp.cut','Ephy.cut','Ephy.cut','Exenopus.cut','Exenopus.cut','Eoncsp.cut','Eoncsp.cut','Exel.cut','Exel.cut','Esus.cut','Esus.cut','Eter.cut','Eter.cut','Epig.cut','Epig.cut','Erabsp.cut','Erabsp.cut','Espu.cut','Espu.cut','Ef1.cut','Ef1.cut','Erhm.cut','Erhm.cut','Emussp.cut','Emussp.cut','Engo.cut','Engo.cut','Emus.cut','Emus.cut','Eppu.cut','Eppu.cut','Ecre.cut','Ecre.cut','Esalsp.cut','Esalsp.cut','Easn.cut','Easn.cut','Esmi.cut','Esmi.cut','Eccr.cut','Eccr.cut','Emva.cut','Emva.cut','Esynsp.cut','Esynsp.cut','Espn.cut','Espn.cut','Etobcp.cut','Etobcp.cut','Ebja.cut','Ebja.cut','Ephv.cut','Ephv.cut','Echi.cut','Echi.cut','Efish.cut','Efish.cut','Epombecai.cut','Epombecai.cut','Eanasp.cut','Eanasp.cut','Eyen.cut','Eyen.cut','Ewht.cut','Ewht.cut','Ehum.cut','Ehum.cut','Etcr.cut','Etcr.cut','Emzecp.cut','Emzecp.cut','Esli.cut','Esli.cut','Ezebrafish.cut','Ezebrafish.cut','Emouse.cut','Emouse.cut','Esoy.cut','Esoy.cut','Eham.cut','Eham.cut','Esyhsp.cut','Esyhsp.cut','Eddi.cut','Eddi.cut','Emaize.cut','Emaize.cut','Emixlg.cut','Emixlg.cut','Eric.cut','Eric.cut','Esta.cut','Esta.cut','Eani.cut','Eani.cut','Epolyomaa2.cut','Epolyomaa2.cut','Ecac.cut','Ecac.cut','Eani_h.cut','Eani_h.cut','Echisp.cut','Echisp.cut','Ehha.cut','Ehha.cut','Ecel.cut','Ecel.cut','Encr.cut','Encr.cut','Epae.cut','Epae.cut','Eslm.cut','Eslm.cut','Ebsu_h.cut','Ebsu_h.cut','Eysp.cut','Eysp.cut','Echos.cut','Echos.cut','Etbr.cut','Etbr.cut','Edrosophila.cut','Edrosophila.cut','Erca.cut','Erca.cut','Ebov.cut','Ebov.cut','Eyeast.cut','Eyeast.cut','Emta.cut','Emta.cut','Epombe.cut','Epombe.cut','Esmu.cut','Esmu.cut','Etrb.cut','Etrb.cut','Ebst.cut','Ebst.cut','Erme.cut','Erme.cut','Eath.cut','Eath.cut','Efmdvpolyp.cut','Efmdvpolyp.cut','Ectr.cut','Ectr.cut','Emam_h.cut','Emam_h.cut','Eadenovirus7.cut','Eadenovirus7.cut','Ecpx.cut','Ecpx.cut','Eshpsp.cut','Eshpsp.cut','Espo.cut','Espo.cut','Emsa.cut','Emsa.cut','Eecoli.cut','Eecoli.cut','Edro.cut','Edro.cut','Ebly.cut','Ebly.cut','Eavi.cut','Eavi.cut','Epse.cut','Epse.cut','Epvu.cut','Epvu.cut','Eeco_h.cut','Eeco_h.cut','Erle.cut','Erle.cut','Ella.cut','Ella.cut','Edayhoff.cut','Edayhoff.cut','Eshp.cut','Eshp.cut','Emse.cut','Emse.cut','Ezma.cut','Ezma.cut','Eddi_h.cut','Eddi_h.cut','Esau.cut','Esau.cut','Echzm.cut','Echzm.cut','Edog.cut','Edog.cut','Ecrisp.cut','Ecrisp.cut','Eeco.cut','Eeco.cut',],
	"second" => ['Ebmo.cut','Ebmo.cut','Etom.cut','Etom.cut','Erat.cut','Erat.cut','Ebsu.cut','Ebsu.cut','Echicken.cut','Echicken.cut','Etob.cut','Etob.cut','Echnt.cut','Echnt.cut','Eyscmt.cut','Eyscmt.cut','Ehin.cut','Ehin.cut','Echmp.cut','Echmp.cut','Ecal.cut','Ecal.cut','Evco.cut','Evco.cut','Epfa.cut','Epfa.cut','Esty.cut','Esty.cut','Echk.cut','Echk.cut','Eaidlav.cut','Eaidlav.cut','Esgi.cut','Esgi.cut','Emtu.cut','Emtu.cut','Ersp.cut','Ersp.cut','Esco.cut','Esco.cut','Ebna.cut','Ebna.cut','Ehuman.cut','Ehuman.cut','Eacc.cut','Eacc.cut','Eyeastcai.cut','Eyeastcai.cut','Eratsp.cut','Eratsp.cut','Ehma.cut','Ehma.cut','Erabbit.cut','Erabbit.cut','Erab.cut','Erab.cut','Emac.cut','Emac.cut','Eysc.cut','Eysc.cut','Emze.cut','Emze.cut','Espi.cut','Espi.cut','Epea.cut','Epea.cut','Ekla.cut','Ekla.cut','Eeca.cut','Eeca.cut','Echzmrubp.cut','Echzmrubp.cut','Eanidmit.cut','Eanidmit.cut','Esv40.cut','Esv40.cut','Epsy.cut','Epsy.cut','Eysc_h.cut','Eysc_h.cut','Eadenovirus5.cut','Eadenovirus5.cut','Espo_h.cut','Espo_h.cut','Eatu.cut','Eatu.cut','Eneu.cut','Eneu.cut','Epot.cut','Epot.cut','Edro_h.cut','Edro_h.cut','Ephix174.cut','Ephix174.cut','Epet.cut','Epet.cut','Ekpn.cut','Ekpn.cut','Ebme.cut','Ebme.cut','Ebovsp.cut','Ebovsp.cut','Esma.cut','Esma.cut','Etetsp.cut','Etetsp.cut','Ephy.cut','Ephy.cut','Exenopus.cut','Exenopus.cut','Eoncsp.cut','Eoncsp.cut','Exel.cut','Exel.cut','Esus.cut','Esus.cut','Eter.cut','Eter.cut','Epig.cut','Epig.cut','Erabsp.cut','Erabsp.cut','Espu.cut','Espu.cut','Ef1.cut','Ef1.cut','Erhm.cut','Erhm.cut','Emussp.cut','Emussp.cut','Engo.cut','Engo.cut','Emus.cut','Emus.cut','Eppu.cut','Eppu.cut','Ecre.cut','Ecre.cut','Esalsp.cut','Esalsp.cut','Easn.cut','Easn.cut','Esmi.cut','Esmi.cut','Eccr.cut','Eccr.cut','Emva.cut','Emva.cut','Esynsp.cut','Esynsp.cut','Espn.cut','Espn.cut','Etobcp.cut','Etobcp.cut','Ephv.cut','Ephv.cut','Ebja.cut','Ebja.cut','Epombecai.cut','Epombecai.cut','Efish.cut','Efish.cut','Echi.cut','Echi.cut','Eanasp.cut','Eanasp.cut','Eyen.cut','Eyen.cut','Ewht.cut','Ewht.cut','Ehum.cut','Ehum.cut','Etcr.cut','Etcr.cut','Esli.cut','Esli.cut','Emzecp.cut','Emzecp.cut','Ezebrafish.cut','Ezebrafish.cut','Esoy.cut','Esoy.cut','Emouse.cut','Emouse.cut','Esyhsp.cut','Esyhsp.cut','Eham.cut','Eham.cut','Eddi.cut','Eddi.cut','Emixlg.cut','Emixlg.cut','Emaize.cut','Emaize.cut','Esta.cut','Esta.cut','Eric.cut','Eric.cut','Eani.cut','Eani.cut','Epolyomaa2.cut','Epolyomaa2.cut','Ecac.cut','Ecac.cut','Eani_h.cut','Eani_h.cut','Ehha.cut','Ehha.cut','Echisp.cut','Echisp.cut','Eslm.cut','Eslm.cut','Epae.cut','Epae.cut','Encr.cut','Encr.cut','Ecel.cut','Ecel.cut','Ebsu_h.cut','Ebsu_h.cut','Eysp.cut','Eysp.cut','Echos.cut','Echos.cut','Etbr.cut','Etbr.cut','Edrosophila.cut','Edrosophila.cut','Erca.cut','Erca.cut','Ebov.cut','Ebov.cut','Eyeast.cut','Eyeast.cut','Epombe.cut','Epombe.cut','Emta.cut','Emta.cut','Esmu.cut','Esmu.cut','Etrb.cut','Etrb.cut','Ebst.cut','Ebst.cut','Erme.cut','Erme.cut','Eath.cut','Eath.cut','Efmdvpolyp.cut','Efmdvpolyp.cut','Ectr.cut','Ectr.cut','Emam_h.cut','Emam_h.cut','Eadenovirus7.cut','Eadenovirus7.cut','Ecpx.cut','Ecpx.cut','Eshpsp.cut','Eshpsp.cut','Espo.cut','Espo.cut','Emsa.cut','Emsa.cut','Eecoli.cut','Eecoli.cut','Edro.cut','Edro.cut','Ebly.cut','Ebly.cut','Eavi.cut','Eavi.cut','Epse.cut','Epse.cut','Epvu.cut','Epvu.cut','Erle.cut','Erle.cut','Eeco_h.cut','Eeco_h.cut','Ella.cut','Ella.cut','Edayhoff.cut','Edayhoff.cut','Eshp.cut','Eshp.cut','Emse.cut','Emse.cut','Ezma.cut','Ezma.cut','Esau.cut','Esau.cut','Eddi_h.cut','Eddi_h.cut','Echzm.cut','Echzm.cut','Edog.cut','Edog.cut','Ecrisp.cut','Ecrisp.cut','Eeco.cut','Eeco.cut',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"first" => { "perl" => '1' },
	"second" => { "perl" => '1' },
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

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"first" => 0,
	"second" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"first" => 1,
	"second" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codcmp.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

