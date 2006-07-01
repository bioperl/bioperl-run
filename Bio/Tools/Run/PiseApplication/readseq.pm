# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::readseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::readseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::readseq

      Bioperl class for:

	READSEQ	 (D. Gilbert)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/readseq.html 
         for available values):


		readseq (String)

		seq (InFile)
			Sequence File
			pipe: readseq_ok_alig

		outfile (OutFile)
			pipe: seqfile

		outformat (Excl)
			Output Sequence Format

		items (String)
			select Item number(s) from several

		allseq (Switch)

		lowcase (Switch)
			Change to lower case (-c)

		uppcase (Switch)
			Change to UPPER case (-C)

		degap (Switch)
			Remove gap symbols (-degap)

		reverse (Switch)
			Change to Reverse-complement (-r)

		listonly (Switch)
			List sequences only (-l)

		width (Integer)
			Sequence line width (-width)

		tab (Integer)
			Left indent (-tab)

		col (Integer)
			Column space within sequence line on output (-col)

		gap (Integer)
			Count gap chars in sequence numbers (-gap)

		nameleft (Excl)
			Name on left/right side

		nametop (Switch)
			Name at top (-nametop)

		numleft (Excl)
			Sequence index on left/right side

		numtop (Excl)
			Index on top/bottom

		match (Switch)
			Use match base (.) for 2..n species (-match)

		interline (Integer)
			How many blank line(s) between sequence blocks

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

http://bioweb.pasteur.fr/seqanal/interfaces/readseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::readseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $readseq = Bio::Tools::Run::PiseApplication::readseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::readseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $readseq = $factory->program('readseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::readseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/readseq.pm

    $self->{COMMAND}   = "readseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "READSEQ";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "D. Gilbert";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"readseq",
	"seq",
	"outfile",
	"outformat",
	"select",
	"allseq",
	"output",
	"pretty",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"readseq",
	"seq", 	# Sequence File
	"outfile",
	"outformat", 	# Output Sequence Format
	"select", 	# Selection parameters
	"items", 	# select Item number(s) from several
	"allseq",
	"output", 	# Output parameters
	"lowcase", 	# Change to lower case (-c)
	"uppcase", 	# Change to UPPER case (-C)
	"degap", 	# Remove gap symbols (-degap)
	"reverse", 	# Change to Reverse-complement (-r)
	"listonly", 	# List sequences only (-l)
	"pretty", 	# Pretty format (18) parameters
	"width", 	# Sequence line width (-width)
	"tab", 	# Left indent (-tab)
	"col", 	# Column space within sequence line on output (-col)
	"gap", 	# Count gap chars in sequence numbers (-gap)
	"nameleft", 	# Name on left/right side
	"nametop", 	# Name at top (-nametop)
	"numleft", 	# Sequence index on left/right side
	"numtop", 	# Index on top/bottom
	"match", 	# Use match base (.) for 2..n species (-match)
	"interline", 	# How many blank line(s) between sequence blocks

    ];

    $self->{TYPE}  = {
	"readseq" => 'String',
	"seq" => 'InFile',
	"outfile" => 'OutFile',
	"outformat" => 'Excl',
	"select" => 'Paragraph',
	"items" => 'String',
	"allseq" => 'Switch',
	"output" => 'Paragraph',
	"lowcase" => 'Switch',
	"uppcase" => 'Switch',
	"degap" => 'Switch',
	"reverse" => 'Switch',
	"listonly" => 'Switch',
	"pretty" => 'Paragraph',
	"width" => 'Integer',
	"tab" => 'Integer',
	"col" => 'Integer',
	"gap" => 'Integer',
	"nameleft" => 'Excl',
	"nametop" => 'Switch',
	"numleft" => 'Excl',
	"numtop" => 'Excl',
	"match" => 'Switch',
	"interline" => 'Integer',

    };

    $self->{FORMAT}  = {
	"readseq" => {
		"perl" => 'readseq',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"outfile" => {
		"perl" => '""',
	},
	"outformat" => {
		"perl" => '" -f$value"',
	},
	"select" => {
	},
	"items" => {
		"perl" => '($value)? " \\-i" . join(",",split(/[,\\s]/,$value))  : "" ',
	},
	"allseq" => {
		"perl" => ' (! $items)? " -a":""',
	},
	"output" => {
	},
	"lowcase" => {
		"perl" => ' ($value)? " -c":""',
	},
	"uppcase" => {
		"perl" => ' ($value)? " -C":""',
	},
	"degap" => {
		"perl" => ' ($value)? " -degap":""',
	},
	"reverse" => {
		"perl" => ' ($value)? " -r":""',
	},
	"listonly" => {
		"perl" => ' ($value)? " -l":""',
	},
	"pretty" => {
	},
	"width" => {
		"perl" => ' (defined $value)?" -width=$value":""',
	},
	"tab" => {
		"perl" => ' (defined $value)?" -tab=$value":""',
	},
	"col" => {
		"perl" => ' (defined $value)?" -col=$value":""',
	},
	"gap" => {
		"perl" => ' (defined $value)? " -gap" : "" ',
	},
	"nameleft" => {
		"perl" => '($value)? " -name$value" : "" ',
	},
	"nametop" => {
		"perl" => ' ($value)? " -nametop" : "" ',
	},
	"numleft" => {
		"perl" => '($value)? " -num$value" : "" ',
	},
	"numtop" => {
		"perl" => ' ($value)? " -num$value" : "" ',
	},
	"match" => {
		"perl" => ' ($value)? " -match=." : "" ',
	},
	"interline" => {
		"perl" => ' (defined $value)?" -inter=$value":""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"readseq" => 0,
	"seq" => 2,
	"outformat" => 3,
	"items" => 3,
	"allseq" => 3,
	"lowcase" => 3,
	"uppcase" => 3,
	"degap" => 3,
	"reverse" => 3,
	"listonly" => 3,
	"width" => 3,
	"tab" => 3,
	"col" => 3,
	"gap" => 3,
	"nameleft" => 3,
	"nametop" => 3,
	"numleft" => 3,
	"numtop" => 3,
	"match" => 3,
	"interline" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readseq",
	"outfile",
	"output",
	"select",
	"pretty",
	"seq",
	"items",
	"allseq",
	"lowcase",
	"uppcase",
	"degap",
	"reverse",
	"listonly",
	"outformat",
	"width",
	"tab",
	"col",
	"gap",
	"nameleft",
	"nametop",
	"numleft",
	"numtop",
	"match",
	"interline",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"readseq" => 1,
	"seq" => 0,
	"outfile" => 1,
	"outformat" => 0,
	"select" => 0,
	"items" => 0,
	"allseq" => 1,
	"output" => 0,
	"lowcase" => 0,
	"uppcase" => 0,
	"degap" => 0,
	"reverse" => 0,
	"listonly" => 0,
	"pretty" => 0,
	"width" => 0,
	"tab" => 0,
	"col" => 0,
	"gap" => 0,
	"nameleft" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,

    };

    $self->{ISCOMMAND}  = {
	"readseq" => 1,
	"seq" => 0,
	"outfile" => 0,
	"outformat" => 0,
	"select" => 0,
	"items" => 0,
	"allseq" => 0,
	"output" => 0,
	"lowcase" => 0,
	"uppcase" => 0,
	"degap" => 0,
	"reverse" => 0,
	"listonly" => 0,
	"pretty" => 0,
	"width" => 0,
	"tab" => 0,
	"col" => 0,
	"gap" => 0,
	"nameleft" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,

    };

    $self->{ISMANDATORY}  = {
	"readseq" => 0,
	"seq" => 1,
	"outfile" => 0,
	"outformat" => 1,
	"select" => 0,
	"items" => 0,
	"allseq" => 0,
	"output" => 0,
	"lowcase" => 0,
	"uppcase" => 0,
	"degap" => 0,
	"reverse" => 0,
	"listonly" => 0,
	"pretty" => 0,
	"width" => 0,
	"tab" => 0,
	"col" => 0,
	"gap" => 0,
	"nameleft" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,

    };

    $self->{PROMPT}  = {
	"readseq" => "",
	"seq" => "Sequence File",
	"outfile" => "",
	"outformat" => "Output Sequence Format",
	"select" => "Selection parameters",
	"items" => "select Item number(s) from several",
	"allseq" => "",
	"output" => "Output parameters",
	"lowcase" => "Change to lower case (-c)",
	"uppcase" => "Change to UPPER case (-C)",
	"degap" => "Remove gap symbols (-degap)",
	"reverse" => "Change to Reverse-complement (-r)",
	"listonly" => "List sequences only (-l)",
	"pretty" => "Pretty format (18) parameters",
	"width" => "Sequence line width (-width)",
	"tab" => "Left indent (-tab)",
	"col" => "Column space within sequence line on output (-col)",
	"gap" => "Count gap chars in sequence numbers (-gap)",
	"nameleft" => "Name on left/right side",
	"nametop" => "Name at top (-nametop)",
	"numleft" => "Sequence index on left/right side",
	"numtop" => "Index on top/bottom",
	"match" => "Use match base (.) for 2..n species (-match)",
	"interline" => "How many blank line(s) between sequence blocks",

    };

    $self->{ISSTANDOUT}  = {
	"readseq" => 0,
	"seq" => 0,
	"outfile" => 1,
	"outformat" => 0,
	"select" => 0,
	"items" => 0,
	"allseq" => 0,
	"output" => 0,
	"lowcase" => 0,
	"uppcase" => 0,
	"degap" => 0,
	"reverse" => 0,
	"listonly" => 0,
	"pretty" => 0,
	"width" => 0,
	"tab" => 0,
	"col" => 0,
	"gap" => 0,
	"nameleft" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,

    };

    $self->{VLIST}  = {

	"outformat" => ['1','1. IG/Stanford','2','2. GenBank/GB','3','3. NBRF','4','4. EMBL','5','5. GCG','6','6. DNAStrider','7','7. Fitch','8','8. Pearson/Fasta','9','9. Zuker','10','10. Olsen (in-only)','11','11. Phylip3.2','12','12. Phylip','13','13. Plain/Raw','14','14. PIR/CODATA','15','15. MSF','16','16. ASN.1','17','17. PAUP','18','18. Pretty (out-only)',],
	"select" => ['items',],
	"output" => ['lowcase','uppcase','degap','reverse','listonly',],
	"pretty" => ['width','tab','col','gap','nameleft','nametop','numleft','numtop','match','interline',],
	"nameleft" => ['left','left','right','right',],
	"numleft" => ['left','left','right','right',],
	"numtop" => ['top','top','bot','bottom',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => '"readseq.out"',
	"outformat" => '8',
	"lowcase" => '0',
	"uppcase" => '0',
	"degap" => '0',
	"reverse" => '0',
	"listonly" => '0',
	"nametop" => '0',
	"match" => '0',

    };

    $self->{PRECOND}  = {
	"readseq" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },
	"select" => { "perl" => '1' },
	"items" => { "perl" => '1' },
	"allseq" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"lowcase" => { "perl" => '1' },
	"uppcase" => { "perl" => '1' },
	"degap" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"listonly" => { "perl" => '1' },
	"pretty" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"tab" => { "perl" => '1' },
	"col" => { "perl" => '1' },
	"gap" => { "perl" => '1' },
	"nameleft" => { "perl" => '1' },
	"nametop" => { "perl" => '1' },
	"numleft" => { "perl" => '1' },
	"numtop" => { "perl" => '1' },
	"match" => { "perl" => '1' },
	"interline" => { "perl" => '1' },

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
	"seq" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"readseq" => 0,
	"seq" => 0,
	"outfile" => 0,
	"outformat" => 0,
	"select" => 0,
	"items" => 0,
	"allseq" => 0,
	"output" => 0,
	"lowcase" => 0,
	"uppcase" => 0,
	"degap" => 0,
	"reverse" => 0,
	"listonly" => 0,
	"pretty" => 0,
	"width" => 0,
	"tab" => 0,
	"col" => 0,
	"gap" => 0,
	"nameleft" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,

    };

    $self->{ISSIMPLE}  = {
	"readseq" => 0,
	"seq" => 1,
	"outfile" => 0,
	"outformat" => 1,
	"select" => 0,
	"items" => 0,
	"allseq" => 0,
	"output" => 0,
	"lowcase" => 0,
	"uppcase" => 0,
	"degap" => 0,
	"reverse" => 0,
	"listonly" => 0,
	"pretty" => 0,
	"width" => 0,
	"tab" => 0,
	"col" => 0,
	"gap" => 0,
	"nameleft" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/readseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

