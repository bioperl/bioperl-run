# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::loadseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::loadseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::loadseq

      Bioperl class for:

	loadseq	load several sequences into a file


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/loadseq.html 
         for available values):


		loadseq (String)

		explanation (String)

		seq (Sequence)
			Sequence to load

		name (String)
			You may give a name to your sequence

		loadresult (String)

		db (Excl)
			Database

		query (String)
			query (Entry name or AC)

		ac (Switch)
			Search with Accession number (except nrl3d)

		outfile (OutFile)
			pipe: seqsfile

		seqfile (Sequence)
			Already loaded sequences file
			pipe: seqsfile

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

http://bioweb.pasteur.fr/seqanal/interfaces/loadseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::loadseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $loadseq = Bio::Tools::Run::PiseApplication::loadseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::loadseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $loadseq = $factory->program('loadseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::loadseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/loadseq.pm

    $self->{COMMAND}   = "loadseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "loadseq";

    $self->{DESCRIPTION}   = "load several sequences into a file";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"loadseq",
	"explanation",
	"howto",
	"seq",
	"name",
	"loadresult",
	"efetch_params",
	"outfile",
	"other_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"loadseq",
	"explanation",
	"howto",
	"seq", 	# Sequence to load
	"name", 	# You may give a name to your sequence
	"loadresult",
	"efetch_params", 	# Efetch parameters
	"db", 	# Database
	"query", 	# query (Entry name or AC)
	"ac", 	# Search with Accession number (except nrl3d)
	"outfile",
	"other_options", 	# Other parameters
	"seqfile", 	# Already loaded sequences file

    ];

    $self->{TYPE}  = {
	"loadseq" => 'String',
	"explanation" => 'String',
	"howto" => 'Results',
	"seq" => 'Sequence',
	"name" => 'String',
	"loadresult" => 'String',
	"efetch_params" => 'Paragraph',
	"db" => 'Excl',
	"query" => 'String',
	"ac" => 'Switch',
	"outfile" => 'OutFile',
	"other_options" => 'Paragraph',
	"seqfile" => 'Sequence',

    };

    $self->{FORMAT}  = {
	"loadseq" => {
		"perl" => '($seq eq "")? "golden " : "fmtseq -all -p -f9 < " ',
	},
	"explanation" => {
		"perl" => '"cp /local/gensoft/doc/loadseq/howto.html .; "',
	},
	"howto" => {
	},
	"seq" => {
		"perl" => '" $seq" ',
	},
	"name" => {
		"perl" => '($seq ne "" && $name ne "")? "; mv load_result tmp; sed \\"s/>,*/> $name/\\" tmp > load_result" : ""',
	},
	"loadresult" => {
		"perl" => '" > load_result"',
	},
	"efetch_params" => {
	},
	"db" => {
		"perl" => '" $db:$query | flat2fasta - "',
	},
	"query" => {
		"perl" => '""',
	},
	"ac" => {
		"perl" => ' ($value)? " -a":""',
	},
	"outfile" => {
		"perl" => '""',
	},
	"other_options" => {
	},
	"seqfile" => {
		"perl" => '($value)? "; cat $seqfile load_result" : "; cat load_result" ',
	},

    };

    $self->{FILENAMES}  = {
	"howto" => 'howto.html',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"loadseq" => 0,
	"explanation" => -10,
	"seq" => 2,
	"name" => 30,
	"loadresult" => 20,
	"db" => 2,
	"query" => 3,
	"ac" => 1,
	"seqfile" => 40,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"explanation",
	"loadseq",
	"howto",
	"efetch_params",
	"outfile",
	"other_options",
	"ac",
	"seq",
	"db",
	"query",
	"loadresult",
	"name",
	"seqfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"loadseq" => 1,
	"explanation" => 1,
	"howto" => 0,
	"seq" => 0,
	"name" => 0,
	"loadresult" => 1,
	"efetch_params" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"outfile" => 1,
	"other_options" => 0,
	"seqfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"loadseq" => 1,
	"explanation" => 0,
	"howto" => 0,
	"seq" => 0,
	"name" => 0,
	"loadresult" => 0,
	"efetch_params" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"outfile" => 0,
	"other_options" => 0,
	"seqfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"loadseq" => 0,
	"explanation" => 0,
	"howto" => 0,
	"seq" => 0,
	"name" => 0,
	"loadresult" => 0,
	"efetch_params" => 0,
	"db" => 1,
	"query" => 1,
	"ac" => 0,
	"outfile" => 0,
	"other_options" => 0,
	"seqfile" => 0,

    };

    $self->{PROMPT}  = {
	"loadseq" => "",
	"explanation" => "",
	"howto" => "",
	"seq" => "Sequence to load",
	"name" => "You may give a name to your sequence",
	"loadresult" => "",
	"efetch_params" => "Efetch parameters",
	"db" => "Database",
	"query" => "query (Entry name or AC)",
	"ac" => "Search with Accession number (except nrl3d)",
	"outfile" => "",
	"other_options" => "Other parameters",
	"seqfile" => "Already loaded sequences file",

    };

    $self->{ISSTANDOUT}  = {
	"loadseq" => 0,
	"explanation" => 0,
	"howto" => 0,
	"seq" => 0,
	"name" => 0,
	"loadresult" => 0,
	"efetch_params" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"outfile" => 1,
	"other_options" => 0,
	"seqfile" => 0,

    };

    $self->{VLIST}  = {

	"efetch_params" => ['db','query','ac',],
	"db" => ['swissprot','swissprot','pir','pir','trembl','trembl','genpept','genpept','genbank','genbank','embl','embl','nrl3d','nrl3d','epd','epd','prosite','prosite',],
	"other_options" => ['seqfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"db" => 'genbank',
	"ac" => '0',
	"outfile" => '"loadseq.out"',

    };

    $self->{PRECOND}  = {
	"loadseq" => { "perl" => '1' },
	"explanation" => { "perl" => '1' },
	"howto" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"loadresult" => { "perl" => '1' },
	"efetch_params" => {
		"perl" => '! $seq',
	},
	"db" => {
		"perl" => '! $seq',
	},
	"query" => {
		"perl" => '! $seq',
	},
	"ac" => {
		"perl" => '! $seq',
	},
	"outfile" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"loadseq" => {
		"perl" => {
			'(! $seq) && (! $query)' => "you must either enter a sequence or an accession number",
		},
	},
	"name" => {
		"perl" => {
			'($name eq "" && $seq ne "seq.data" && ($name=$seq) && 0)' => "no message",
		},
	},
	"ac" => {
		"perl" => {
			'$ac && $db eq "nrl3d"' => "No Accesion number for Nrl3d",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "seqsfile",
	},

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
	"loadseq" => 0,
	"explanation" => 0,
	"howto" => 0,
	"seq" => 0,
	"name" => 0,
	"loadresult" => 0,
	"efetch_params" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"outfile" => 0,
	"other_options" => 0,
	"seqfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"loadseq" => 0,
	"explanation" => 0,
	"howto" => 0,
	"seq" => 1,
	"name" => 1,
	"loadresult" => 0,
	"efetch_params" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"outfile" => 0,
	"other_options" => 0,
	"seqfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"seq" => [
		"This form allows you to progressively load your sequences into a file, one by one. It\'s purpose is to help users who do not have a concatenate utility on their computer to build a multiple sequence file. The sequence is automatically converted in FASTA format.",
		"Load your first sequence, and wait for the output. You will be able to choose loadseq in the menu to go on with additional sequences.",
		"You may also provide an accession number or entry name, which will be fetched and loaded in the sequences file (advanced form).",
		"You may also load more than one sequence at a time.",
	],
	"name" => [
		"If you load not more than one sequence...",
	],
	"seqfile" => [
		"You don\'t need to enter this parameter, normally. You should enter your sequences above (Sequence to load).",
		"This is the intermediate file containing already loaded sequences.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/loadseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

