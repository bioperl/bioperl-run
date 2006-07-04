# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::clustalw_convert
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::clustalw_convert

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::clustalw_convert

      Bioperl class for:

	Clustalw	format conversion (Des Higgins)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/clustalw_convert.html 
         for available values):


		clustalw_convert (String)

		seqfile (Sequence)
			Alignment to convert (-infile)
			pipe: readseq_ok_alig

		formats (Excl)
			Output format (-output)

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

http://bioweb.pasteur.fr/seqanal/interfaces/clustalw_convert.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::clustalw_convert;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $clustalw_convert = Bio::Tools::Run::PiseApplication::clustalw_convert->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::clustalw_convert object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $clustalw_convert = $factory->program('clustalw_convert');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::clustalw_convert.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/clustalw_convert.pm

    $self->{COMMAND}   = "clustalw_convert";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Clustalw";

    $self->{DESCRIPTION}   = "format conversion";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Des Higgins";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"clustalw_convert",
	"seqfile",
	"formats",
	"gdefile",
	"clufile",
	"phyfile",
	"gcgfile",
	"pirfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"clustalw_convert",
	"seqfile", 	# Alignment to convert (-infile)
	"formats", 	# Output format (-output)
	"gdefile",
	"clufile",
	"phyfile",
	"gcgfile",
	"pirfile",

    ];

    $self->{TYPE}  = {
	"clustalw_convert" => 'String',
	"seqfile" => 'Sequence',
	"formats" => 'Excl',
	"gdefile" => 'Results',
	"clufile" => 'Results',
	"phyfile" => 'Results',
	"gcgfile" => 'Results',
	"pirfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"clustalw_convert" => {
		"perl" => '"clustalw -convert"',
	},
	"seqfile" => {
		"perl" => '  " -infile=$value"',
	},
	"formats" => {
		"perl" => '  " -output=$value"',
	},
	"gdefile" => {
	},
	"clufile" => {
	},
	"phyfile" => {
	},
	"gcgfile" => {
	},
	"pirfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"gdefile" => '*.gde',
	"clufile" => '*.aln',
	"phyfile" => '*.ph*',
	"gcgfile" => '*.msf',
	"pirfile" => '*.pir',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"clustalw_convert" => 0,
	"seqfile" => 1,
	"formats" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"clustalw_convert",
	"pirfile",
	"clufile",
	"gdefile",
	"phyfile",
	"gcgfile",
	"seqfile",
	"formats",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"clustalw_convert" => 1,
	"seqfile" => 0,
	"formats" => 0,
	"gdefile" => 0,
	"clufile" => 0,
	"phyfile" => 0,
	"gcgfile" => 0,
	"pirfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"clustalw_convert" => 1,
	"seqfile" => 0,
	"formats" => 0,
	"gdefile" => 0,
	"clufile" => 0,
	"phyfile" => 0,
	"gcgfile" => 0,
	"pirfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"clustalw_convert" => 0,
	"seqfile" => 1,
	"formats" => 1,
	"gdefile" => 0,
	"clufile" => 0,
	"phyfile" => 0,
	"gcgfile" => 0,
	"pirfile" => 0,

    };

    $self->{PROMPT}  = {
	"clustalw_convert" => "",
	"seqfile" => "Alignment to convert (-infile)",
	"formats" => "Output format (-output)",
	"gdefile" => "",
	"clufile" => "",
	"phyfile" => "",
	"gcgfile" => "",
	"pirfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"clustalw_convert" => 0,
	"seqfile" => 0,
	"formats" => 0,
	"gdefile" => 0,
	"clufile" => 0,
	"phyfile" => 0,
	"gcgfile" => 0,
	"pirfile" => 0,

    };

    $self->{VLIST}  = {

	"formats" => ['CLU','CLUSTALW','GCG','GCG/MSF','PIR','NBRF/PIR','GDE','GDE','PHYLIP','PHYLIP',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"formats" => 'GCG',

    };

    $self->{PRECOND}  = {
	"clustalw_convert" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"formats" => { "perl" => '1' },
	"gdefile" => {
		"perl" => '$formats eq "GDE"',
	},
	"clufile" => {
		"perl" => '$formats eq "CLU"',
	},
	"phyfile" => {
		"perl" => '$formats eq "PHYLIP"',
	},
	"gcgfile" => {
		"perl" => '$formats eq "GCG"',
	},
	"pirfile" => {
		"perl" => '$formats eq "PIR"',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"clufile" => {
		 '1' => "readseq_ok_alig",
	},
	"phyfile" => {
		 '1' => "readseq_ok_alig",
	},
	"gcgfile" => {
		 '1' => "readseq_ok_alig",
	},
	"pirfile" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqfile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"clustalw_convert" => 0,
	"seqfile" => 0,
	"formats" => 0,
	"gdefile" => 0,
	"clufile" => 0,
	"phyfile" => 0,
	"gcgfile" => 0,
	"pirfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"clustalw_convert" => 0,
	"seqfile" => 1,
	"formats" => 1,
	"gdefile" => 0,
	"clufile" => 0,
	"phyfile" => 0,
	"gcgfile" => 0,
	"pirfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"seqfile" => [
		"7 formats are automatically recognised: NBRF/PIR, EMBL/SWISSPROT, Pearson (Fasta), Clustal (*.aln), GCG/MSF (Pileup), GCG9/RSF and GDE flat file. All non-alphabetic characters (spaces, digits, punctuation marks) are ignored except \'-\' which is used to indicate a GAP (\'.\' in GCG/MSF).",
		"FASTA and NBRF/PIR formats are recognised by having a \'>\' as the first character in the file. ",
		"EMBL/Swiss Prot formats are recognised by the letters ID at the start of the file (the token for the entry name field). ",
		"CLUSTAL format is recognised by the word CLUSTAL at the beginning of the file.",
		"GCG/MSF format is recognised by one of the following:",
		" - the word PileUp at the start of the file. ",
		" - the word !!AA_MULTIPLE_ALIGNMENT or !!NA_MULTIPLE_ALIGNMENT at the start of the file.",
		" - the word MSF on the first line of the line, and the characters .. at the end of this line.",
		"GCG/RSF format is recognised by the word !!RICH_SEQUENCE at the beginning of the file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/clustalw_convert.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

