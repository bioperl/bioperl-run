# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::grailclnt
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::grailclnt

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::grailclnt

      Bioperl class for:

	GRAILCLNT	Grail client (Xu, Einstein, Mural, Shah, Uberbacher)

	References:

		Xu, Y., Einstein, J. R., Mural, R.J., Shah, M. and Uberbacher, E.C., (1994) An Improved System for Exon Recognition and Gene Modeling in Human DNA Sequences, Published Presentation: The Second International Conference on Intelligent Systems for Molecular Biology, Stanford University, San Francisco, CA, August 14-17, 1994.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/grailclnt.html 
         for available values):


		grailclnt (String)

		seq (Sequence)
			Sequence

		feature (Excl)
			Which feature?

		organism (Excl)
			Organism

		header (Switch)
			Header

		translation (Switch)
			Translation

		strandscores (Switch)
			Strandscores (grail1)

		shadowexons (Switch)
			Shadowexons (grail 1.a or grail2)

		clusters (Switch)
			Clusters (grail 2)

		cluster_file (InFile)
			grail2exons results file
			pipe: grail_cluster

		modelexon_translation (Switch)
			Gene model exons translation

		genemodel_translation (Switch)
			Entire gene models translation

		auto_strand (Switch)
			AUTO STRAND

		start_strand (Integer)
			AUTO STRAND start

		end_strand (Integer)
			AUTO STRAND end

		forward_strand (Switch)
			FORWARD_STRAND

		reverse_strand (Switch)
			REVERSE_STRAND

		grail2_file (InFile)
			grail2exons results file
			pipe: grail_cluster

		fserr_strand (Excl)
			Strand

		rpttv_organism (String)

		start_seq (String)

		end_seq (String)

		end_request (String)

		outfile (OutFile)
			Result file
			pipe: grail_cluster

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

http://bioweb.pasteur.fr/seqanal/interfaces/grailclnt.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::grailclnt;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $grailclnt = Bio::Tools::Run::PiseApplication::grailclnt->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::grailclnt object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $grailclnt = $factory->program('grailclnt');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::grailclnt.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/grailclnt.pm

    $self->{COMMAND}   = "grailclnt";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "GRAILCLNT";

    $self->{DESCRIPTION}   = "Grail client";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Xu, Einstein, Mural, Shah, Uberbacher";

    $self->{REFERENCE}   = [

         "Xu, Y., Einstein, J. R., Mural, R.J., Shah, M. and Uberbacher, E.C., (1994) An Improved System for Exon Recognition and Gene Modeling in Human DNA Sequences, Published Presentation: The Second International Conference on Intelligent Systems for Molecular Biology, Stanford University, San Francisco, CA, August 14-17, 1994.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"grailclnt",
	"seq",
	"feature",
	"organism",
	"header",
	"exons_options",
	"gap_options",
	"polIIprom_options",
	"fserr_options",
	"rpttv_organism",
	"start_seq",
	"end_seq",
	"end_request",
	"input_file",
	"outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"grailclnt",
	"seq", 	# Sequence
	"feature", 	# Which feature?
	"organism", 	# Organism
	"header", 	# Header
	"exons_options", 	# Exons options
	"translation", 	# Translation
	"strandscores", 	# Strandscores (grail1)
	"shadowexons", 	# Shadowexons (grail 1.a or grail2)
	"clusters", 	# Clusters (grail 2)
	"gap_options", 	# Gene modelling options
	"cluster_file", 	# grail2exons results file
	"modelexon_translation", 	# Gene model exons translation
	"genemodel_translation", 	# Entire gene models translation
	"auto_strand", 	# AUTO STRAND
	"start_strand", 	# AUTO STRAND start
	"end_strand", 	# AUTO STRAND end
	"forward_strand", 	# FORWARD_STRAND
	"reverse_strand", 	# REVERSE_STRAND
	"polIIprom_options", 	# Pol II Promoters options
	"grail2_file", 	# grail2exons results file
	"fserr_options", 	# fserr options
	"fserr_strand", 	# Strand
	"rpttv_organism",
	"start_seq",
	"end_seq",
	"end_request",
	"input_file",
	"outfile", 	# Result file

    ];

    $self->{TYPE}  = {
	"grailclnt" => 'String',
	"seq" => 'Sequence',
	"feature" => 'Excl',
	"organism" => 'Excl',
	"header" => 'Switch',
	"exons_options" => 'Paragraph',
	"translation" => 'Switch',
	"strandscores" => 'Switch',
	"shadowexons" => 'Switch',
	"clusters" => 'Switch',
	"gap_options" => 'Paragraph',
	"cluster_file" => 'InFile',
	"modelexon_translation" => 'Switch',
	"genemodel_translation" => 'Switch',
	"auto_strand" => 'Switch',
	"start_strand" => 'Integer',
	"end_strand" => 'Integer',
	"forward_strand" => 'Switch',
	"reverse_strand" => 'Switch',
	"polIIprom_options" => 'Paragraph',
	"grail2_file" => 'InFile',
	"fserr_options" => 'Paragraph',
	"fserr_strand" => 'Excl',
	"rpttv_organism" => 'String',
	"start_seq" => 'String',
	"end_seq" => 'String',
	"end_request" => 'String',
	"input_file" => 'Results',
	"outfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"grailclnt" => {
		"perl" => '"cat grail_input_* > grail_input; grailclnt -host grailsrv.lsd.ornl.gov -port 2050 < grail_input " ',
	},
	"seq" => {
		"perl" => '" ln -s $seq grail_input_a4 ;"',
	},
	"feature" => {
		"perl" => '($value eq "cpg" || $value eq "rpttv" || $value eq "smprpt")? "\\n\\[Request\\_$value\\_1.3\\]\\n\\n" : "\\n\\[Request\\_$value\\_$organism\\_1.3\\]\\n\\n" ',
	},
	"organism" => {
		"perl" => '""',
	},
	"header" => {
		"perl" => '($value)? "[Option= header]\\n" : ""',
	},
	"exons_options" => {
	},
	"translation" => {
		"perl" => '($value)? "[Option= translation]\\n" : ""',
	},
	"strandscores" => {
		"perl" => '($value)? "[Option= strandscores]\\n" : ""',
	},
	"shadowexons" => {
		"perl" => '($value)? "[Option= shadowexons]\\n" : ""',
	},
	"clusters" => {
		"perl" => '($value)? "[Option= clusters]\\n" : ""',
	},
	"gap_options" => {
	},
	"cluster_file" => {
		"perl" => '($value)? "sed -n \\"/^.Start clusters/,/^.End clusters/p\\" $cluster_file > grail_input_b4 ;" : "" ',
	},
	"modelexon_translation" => {
		"perl" => '($value)? "[Option= modelexon_translation]\\n" : ""',
	},
	"genemodel_translation" => {
		"perl" => '($value)? "[Option= genemodel_translation]\\n" : ""',
	},
	"auto_strand" => {
		"perl" => '($value)? "[Params= AUTO_STRAND $start_strand $end_strand]\\n" : ""',
	},
	"start_strand" => {
		"perl" => ' "" ',
	},
	"end_strand" => {
		"perl" => ' "" ',
	},
	"forward_strand" => {
		"perl" => '($value)? "[Params= FORWARD_STRAND]\\n" : ""',
	},
	"reverse_strand" => {
		"perl" => '($value)? "[Params= REVERSE_STRAND]\\n" : ""',
	},
	"polIIprom_options" => {
	},
	"grail2_file" => {
		"perl" => '($value)? " ln -s $grail2_file grail_input_b2 ;" : "" ',
	},
	"fserr_options" => {
	},
	"fserr_strand" => {
		"perl" => '"[Params= $value]\\n" ',
	},
	"rpttv_organism" => {
		"perl" => '"\\n\\n[Params= $organism]\\n\\n"',
	},
	"start_seq" => {
		"perl" => '"\\n\\n[Start DNASequence]\\n\\n"',
	},
	"end_seq" => {
		"perl" => '"\\n\\n[End DNASequence]\\n\\n"',
	},
	"end_request" => {
		"perl" => '"\\n\\n[End_Request]\\n\\n"',
	},
	"input_file" => {
	},
	"outfile" => {
		"perl" => '($value)? " > $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"input_file" => 'grail_input',

    };

    $self->{SEQFMT}  = {
	"seq" => [13],

    };

    $self->{GROUP}  = {
	"grailclnt" => 2,
	"seq" => 1,
	"feature" => 2,
	"organism" => 2,
	"header" => 3,
	"translation" => 3,
	"strandscores" => 3,
	"shadowexons" => 3,
	"clusters" => 3,
	"cluster_file" => 1,
	"modelexon_translation" => 3,
	"genemodel_translation" => 3,
	"auto_strand" => 4,
	"forward_strand" => 4,
	"reverse_strand" => 4,
	"grail2_file" => 1,
	"fserr_strand" => 4,
	"rpttv_organism" => 4,
	"outfile" => 10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"fserr_options",
	"start_seq",
	"end_seq",
	"end_request",
	"input_file",
	"exons_options",
	"start_strand",
	"gap_options",
	"end_strand",
	"polIIprom_options",
	"seq",
	"cluster_file",
	"grail2_file",
	"grailclnt",
	"feature",
	"organism",
	"translation",
	"strandscores",
	"shadowexons",
	"clusters",
	"modelexon_translation",
	"genemodel_translation",
	"header",
	"rpttv_organism",
	"auto_strand",
	"forward_strand",
	"reverse_strand",
	"fserr_strand",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"grailclnt" => 1,
	"seq" => 0,
	"feature" => 0,
	"organism" => 0,
	"header" => 0,
	"exons_options" => 0,
	"translation" => 0,
	"strandscores" => 0,
	"shadowexons" => 0,
	"clusters" => 0,
	"gap_options" => 0,
	"cluster_file" => 0,
	"modelexon_translation" => 0,
	"genemodel_translation" => 0,
	"auto_strand" => 0,
	"start_strand" => 0,
	"end_strand" => 0,
	"forward_strand" => 0,
	"reverse_strand" => 0,
	"polIIprom_options" => 0,
	"grail2_file" => 0,
	"fserr_options" => 0,
	"fserr_strand" => 0,
	"rpttv_organism" => 1,
	"start_seq" => 1,
	"end_seq" => 1,
	"end_request" => 1,
	"input_file" => 0,
	"outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"grailclnt" => 1,
	"seq" => 0,
	"feature" => 0,
	"organism" => 0,
	"header" => 0,
	"exons_options" => 0,
	"translation" => 0,
	"strandscores" => 0,
	"shadowexons" => 0,
	"clusters" => 0,
	"gap_options" => 0,
	"cluster_file" => 0,
	"modelexon_translation" => 0,
	"genemodel_translation" => 0,
	"auto_strand" => 0,
	"start_strand" => 0,
	"end_strand" => 0,
	"forward_strand" => 0,
	"reverse_strand" => 0,
	"polIIprom_options" => 0,
	"grail2_file" => 0,
	"fserr_options" => 0,
	"fserr_strand" => 0,
	"rpttv_organism" => 0,
	"start_seq" => 0,
	"end_seq" => 0,
	"end_request" => 0,
	"input_file" => 0,
	"outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"grailclnt" => 0,
	"seq" => 1,
	"feature" => 1,
	"organism" => 1,
	"header" => 0,
	"exons_options" => 0,
	"translation" => 0,
	"strandscores" => 0,
	"shadowexons" => 0,
	"clusters" => 0,
	"gap_options" => 0,
	"cluster_file" => 1,
	"modelexon_translation" => 0,
	"genemodel_translation" => 0,
	"auto_strand" => 0,
	"start_strand" => 1,
	"end_strand" => 1,
	"forward_strand" => 0,
	"reverse_strand" => 0,
	"polIIprom_options" => 0,
	"grail2_file" => 1,
	"fserr_options" => 0,
	"fserr_strand" => 1,
	"rpttv_organism" => 0,
	"start_seq" => 0,
	"end_seq" => 0,
	"end_request" => 0,
	"input_file" => 0,
	"outfile" => 0,

    };

    $self->{PROMPT}  = {
	"grailclnt" => "",
	"seq" => "Sequence",
	"feature" => "Which feature?",
	"organism" => "Organism",
	"header" => "Header",
	"exons_options" => "Exons options",
	"translation" => "Translation",
	"strandscores" => "Strandscores (grail1)",
	"shadowexons" => "Shadowexons (grail 1.a or grail2)",
	"clusters" => "Clusters (grail 2)",
	"gap_options" => "Gene modelling options",
	"cluster_file" => "grail2exons results file",
	"modelexon_translation" => "Gene model exons translation",
	"genemodel_translation" => "Entire gene models translation",
	"auto_strand" => "AUTO STRAND",
	"start_strand" => "AUTO STRAND start",
	"end_strand" => "AUTO STRAND end",
	"forward_strand" => "FORWARD_STRAND",
	"reverse_strand" => "REVERSE_STRAND",
	"polIIprom_options" => "Pol II Promoters options",
	"grail2_file" => "grail2exons results file",
	"fserr_options" => "fserr options",
	"fserr_strand" => "Strand",
	"rpttv_organism" => "",
	"start_seq" => "",
	"end_seq" => "",
	"end_request" => "",
	"input_file" => "",
	"outfile" => "Result file",

    };

    $self->{ISSTANDOUT}  = {
	"grailclnt" => 0,
	"seq" => 0,
	"feature" => 0,
	"organism" => 0,
	"header" => 0,
	"exons_options" => 0,
	"translation" => 0,
	"strandscores" => 0,
	"shadowexons" => 0,
	"clusters" => 0,
	"gap_options" => 0,
	"cluster_file" => 0,
	"modelexon_translation" => 0,
	"genemodel_translation" => 0,
	"auto_strand" => 0,
	"start_strand" => 0,
	"end_strand" => 0,
	"forward_strand" => 0,
	"reverse_strand" => 0,
	"polIIprom_options" => 0,
	"grail2_file" => 0,
	"fserr_options" => 0,
	"fserr_strand" => 0,
	"rpttv_organism" => 0,
	"start_seq" => 0,
	"end_seq" => 0,
	"end_request" => 0,
	"input_file" => 0,
	"outfile" => 1,

    };

    $self->{VLIST}  = {

	"feature" => ['grail1exons','grail1exons: Protein Coding Regions (grail 1)','grail1aexons','grail1aexons: Protein Coding Regions (grail 1.a)','grail2exons','grail2exons: Protein Coding Regions (grail 2)','gap2','gap2: Gene Modeling','polya','polya: PolyA sites','polIIprom','polIIprom: Pol II Promoters','cpg','cpg: CpG Islands','rpttv','rpttv: repetitive DNA elements','smprpt','smprpt: simple repeats','fserr','fserr: Frame Shift Errors',],
	"organism" => ['human','Human','mouse','Mouse','arabd','Arabidopsis','droso','Drosophila','ecoli','E. coli',],
	"exons_options" => ['translation','strandscores','shadowexons','clusters',],
	"gap_options" => ['cluster_file','modelexon_translation','genemodel_translation','auto_strand','start_strand','end_strand','forward_strand','reverse_strand',],
	"polIIprom_options" => ['grail2_file',],
	"fserr_options" => ['fserr_strand',],
	"fserr_strand" => ['AUTO_STRAND','AUTO_STRAND','FORWARD_STRAND','FORWARD_STRAND','REVERSE_STRAND','REVERSE_STRAND',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"feature" => 'grail2exons',
	"organism" => 'human',
	"header" => '0',
	"translation" => '0',
	"strandscores" => '0',
	"shadowexons" => '1',
	"clusters" => '1',
	"modelexon_translation" => '0',
	"genemodel_translation" => '0',
	"auto_strand" => '1',
	"forward_strand" => '0',
	"reverse_strand" => '0',
	"fserr_strand" => 'AUTO_STRAND',
	"outfile" => 'grailclnt.txt',

    };

    $self->{PRECOND}  = {
	"grailclnt" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"feature" => { "perl" => '1' },
	"organism" => { "perl" => '1' },
	"header" => { "perl" => '1' },
	"exons_options" => {
		"perl" => '$feature =~ /grail/',
	},
	"translation" => {
		"perl" => '$feature =~ /grail/',
	},
	"strandscores" => {
		"perl" => '$feature =~ /grail/ && $feature eq "grail1exons" ',
	},
	"shadowexons" => {
		"perl" => '$feature =~ /grail/ && $feature ne "grail1exons" ',
	},
	"clusters" => {
		"perl" => '$feature =~ /grail/ && $feature eq "grail2exons" ',
	},
	"gap_options" => {
		"perl" => '$feature eq "gap2" ',
	},
	"cluster_file" => {
		"perl" => '$feature eq "gap2" ',
	},
	"modelexon_translation" => {
		"perl" => '$feature eq "gap2" ',
	},
	"genemodel_translation" => {
		"perl" => '$feature eq "gap2" ',
	},
	"auto_strand" => {
		"perl" => '$feature eq "gap2" ',
	},
	"start_strand" => {
		"perl" => '$feature eq "gap2"  && $auto_strand',
	},
	"end_strand" => {
		"perl" => '$feature eq "gap2"  && $auto_strand',
	},
	"forward_strand" => {
		"perl" => '$feature eq "gap2"  && ! $auto_strand',
	},
	"reverse_strand" => {
		"perl" => '$feature eq "gap2"  && ! $auto_strand',
	},
	"polIIprom_options" => {
		"perl" => '$feature eq "polIIprom" ',
	},
	"grail2_file" => {
		"perl" => '$feature eq "polIIprom" ',
	},
	"fserr_options" => {
		"perl" => '$feature eq "fserr" ',
	},
	"fserr_strand" => {
		"perl" => '$feature eq "fserr" ',
	},
	"rpttv_organism" => {
		"perl" => '$feature eq "rpttv" ',
	},
	"start_seq" => { "perl" => '1' },
	"end_seq" => { "perl" => '1' },
	"end_request" => { "perl" => '1' },
	"input_file" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"feature" => {
		"perl" => {
			'$organism eq "ecoli" && (! ($feature eq "grail1" || $feature eq "smprpt")) ' => "E. coli is available only for grail1 or simple repeats",
			'$feature eq "polIIprom" && (! ($organism eq "human" || $organism eq "mouse"))' => "polIIprom is available only for Human or Mouse",
			'$feature eq "rpttv" && (! ($organism eq "human" || $organism eq "mouse"))' => "Repetitive DNA is available only for Human or Mouse",
			'$organism eq "droso" && ($feature =~ /grail1/)' => "Grail 1 or 1.a is not available for drosophila",
			'$feature eq "fserr" && (! ($organism eq "human" || $organism eq "mouse"))' => "fserr is available only for Human or Mouse",
			'$feature eq "polya" && (! ($organism eq "human" || $organism eq "mouse"))' => "polya is available only for Human or Mouse",
			'$organism eq "arabd" && ($feature =~ /grail1/)' => "Grail 1 or 1.a is not available for arabidopsis",
			'$feature eq "cpg" && (! ($organism eq "human" || $organism eq "mouse"))' => "CpG is available only for Human or Mouse",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '$feature eq "grail2exons" ' => "grail_cluster",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"cluster_file" => {
		 "grail_cluster" => '1',
	},
	"grail2_file" => {
		 "grail_cluster" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"grailclnt" => 0,
	"seq" => 0,
	"feature" => 0,
	"organism" => 0,
	"header" => 0,
	"exons_options" => 0,
	"translation" => 0,
	"strandscores" => 0,
	"shadowexons" => 0,
	"clusters" => 0,
	"gap_options" => 0,
	"cluster_file" => 0,
	"modelexon_translation" => 0,
	"genemodel_translation" => 0,
	"auto_strand" => 0,
	"start_strand" => 0,
	"end_strand" => 0,
	"forward_strand" => 0,
	"reverse_strand" => 0,
	"polIIprom_options" => 0,
	"grail2_file" => 0,
	"fserr_options" => 0,
	"fserr_strand" => 0,
	"rpttv_organism" => 0,
	"start_seq" => 0,
	"end_seq" => 0,
	"end_request" => 0,
	"input_file" => 0,
	"outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"grailclnt" => 0,
	"seq" => 1,
	"feature" => 0,
	"organism" => 1,
	"header" => 0,
	"exons_options" => 0,
	"translation" => 0,
	"strandscores" => 0,
	"shadowexons" => 0,
	"clusters" => 0,
	"gap_options" => 0,
	"cluster_file" => 0,
	"modelexon_translation" => 0,
	"genemodel_translation" => 0,
	"auto_strand" => 0,
	"start_strand" => 0,
	"end_strand" => 0,
	"forward_strand" => 0,
	"reverse_strand" => 0,
	"polIIprom_options" => 0,
	"grail2_file" => 0,
	"fserr_options" => 0,
	"fserr_strand" => 0,
	"rpttv_organism" => 0,
	"start_seq" => 0,
	"end_seq" => 0,
	"end_request" => 0,
	"input_file" => 0,
	"outfile" => 0,

    };

    $self->{PARAMFILE}  = {
	"feature" => "grail_input_a1",
	"header" => "grail_input_a1",
	"translation" => "grail_input_a1",
	"strandscores" => "grail_input_a1",
	"shadowexons" => "grail_input_a1",
	"clusters" => "grail_input_a1",
	"modelexon_translation" => "grail_input_a1",
	"genemodel_translation" => "grail_input_a1",
	"auto_strand" => "grail_input_a1",
	"start_strand" => "grail_input_a1",
	"end_strand" => "grail_input_a1",
	"forward_strand" => "grail_input_a1",
	"reverse_strand" => "grail_input_a1",
	"fserr_strand" => "grail_input_a1",
	"rpttv_organism" => "grail_input_a1",
	"start_seq" => "grail_input_a3",
	"end_seq" => "grail_input_a5",
	"end_request" => "grail_input_z9",

    };

    $self->{COMMENT}  = {
	"feature" => [
		"The coding recognition portion of the system uses a neural network which combines a series of coding prediction algorithms. There are three basic versions of this neural network, GRAIL 1, GRAIL 1a and GRAIL 2: ",
		"GRAIL 1 has been in place for about five years. It uses a neural network described in PNAS 88, 11261-11265, which recognizes coding potential within a fixed size (100 base) window. It evaluates coding potential without looking for additional features (information such as splice junctions, etc).",
		"GRAIL 1a is an updated version of GRAIL 1. It uses a fixed-length window to locate the potential coding regions and then evaluates a number of discrete candidates of different lengths around each potential coding region, using information from the two 60-base regions adjacent to that coding region, to find the \'best\' boundaries for that coding region.",
		"GRAIL 2 uses variable-length windows tailored to each potential exon candidate, defined as an open reading frame bounded by a pair of start/donor, acceptor/donor or acceptor/stop sites. This scheme facilitates the use of more genomic context information (splice junctions, translation starts, non-coding scores of 60-base regions on either side of a putative exon) in the exon recognition process. GRAIL 2 is therefore not appropriate for sequences without genomic context (when the regions adjacent to an exon are not present).",
	],
	"shadowexons" => [
		"This feature is needed for a further polIIpromoters analysis.",
	],
	"clusters" => [
		"This feature is needed for a further Gene Modelling analysis with GAP2 or polIIpromoters.",
	],
	"cluster_file" => [
		"For gap2 (gene assembly) the cluster tables returned by grail2exons must be included.",
		"So what you have to do here is to put your grail2exons results, the program will extract clusters from this data.",
	],
	"grail2_file" => [
		"For Pol II promoters, all the results of grail2 must be included.",
		"The [Start/end header] lines must be removed.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/grailclnt.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

