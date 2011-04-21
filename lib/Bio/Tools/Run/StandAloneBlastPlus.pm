# $Id$
#
# BioPerl module for Bio::Tools::Run::StandAloneBlastPlus
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Mark A. Jensen <maj -at- fortinbras -dot- us>
#
# Copyright Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::StandAloneBlastPlus - Compute with NCBI's blast+ suite *ALPHA*

=head1 SYNOPSIS

B<NOTE>: This module is related to the
L<Bio::Tools::Run::StandAloneBlast> system in name (and inspiration)
only. You must use this module directly.

 # existing blastdb:
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb'
 );
 
 # create blastdb from fasta file and attach
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb',
   -db_data => 'myseqs.fas',
   -create => 1
 );
 
 # create blastdb from BioPerl sequence collection objects
 $alnio = Bio::AlignIO->new( -file => 'alignment.msf' );
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb',
   -db_data => $alnio,
   -create => 1
 );

 @seqs = $alnio->next_aln->each_seq;
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb',
   -db_data => \@seqs,
   -create => 1
 );

 # create database with masks

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
  -db_name => 'my_masked_db',
  -db_data => 'myseqs.fas',
  -masker => 'dustmasker',
  -mask_data => 'maskseqs.fas',
  -create => 1
 );

 # create a mask datafile separately
 $mask_file = $fac->make_mask(
   -data => 'maskseqs.fas',
   -masker => 'dustmasker'
 );

 # query database for metadata
 $info_hash = $fac->db_info;
 $num_seq = $fac->db_num_sequences;
 @mask_metadata = @{ $fac->db_filter_algorithms };

 # perform blast methods
 $result = $fac->tblastn( -query => $seqio );
 # see Bio::Tools::Run::StandAloneBlastPlus::BlastMethods 
 # for many more details

=head1 DESCRIPTION

B<NOTE:> This module requires BLAST+ v. 2.2.24+ and higher.  Until the API
stabilizes for BLAST+, consider this module highly experimental.

This module along with
L<Bio::Tools::Run::StandAloneBlastPlus::BlastMethods> allows the user
to perform BLAST functions using the external program suite C<blast+>
(available at
L<ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/>), using
BioPerl objects and L<Bio::SearchIO> facilities. This wrapper can
prepare BLAST databases as well as run BLAST searches. It can also be
used to run C<blast+> programs independently.

This module encapsulates object construction and production of
databases and masks. Blast analysis methods (C<blastp, psiblast>,
etc>) are contained in
L<Bio::Tools::Run::StandAloneBlastPlus::BlastMethods>.

=head1 USAGE

The basic mantra is to (1) create a BlastPlus factory using the
C<new()> constructor, and (2) perform BLAST analyses by calling the
desired BLAST program by name off the factory object. The blast
database itself and any masking data are attached to the factory
object (step 1). Query sequences and any parameters associated with
particular programs are provided to the blast method call (step 2),
and are run against the attached database.

=head2 Factory construction/initialization

The factory needs to be told where the blast+ programs live. The
C<BLASTPLUSDIR> environment variable will be checked for the default
executable directory.  The program directory can be set for individual
factory instances with the C<PROG_DIR> parameter. All the blast+
programs must be accessible from that directory (i.e., as executable
files or symlinks).

Either the database or BLAST subject data must be specified at object
construction. Databases can be pre-existing formatted BLAST dbs, or
can be built directly from fasta sequence files or BioPerl sequence
object collections of several kinds. The key constructor parameters
are C<DB_NAME>, C<DB_DATA>, C<DB_DIR>.

To specify a pre-existing BLAST database, use C<DB_NAME> alone:

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
     -DB_NAME => 'mydb'
 );

The directory can be specified along with the basename, or separately
with C<DB_DIR>:
 
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
     -DB_NAME => '~/home/blast/mydb'
 );

 #same as

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
     -DB_NAME => 'mydb', -DB_DIR => '~/home/blast'
 );

To create a BLAST database de novo, see L</Creating a BLAST database>.

If you wish to apply pre-existing mask data (i.e., the final ASN1
output from one of the blast+ masker programs), to the database before
querying, specify it with C<MASK_FILE>:

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
     -DB_NAME => 'mydb', -MASK_FILE => 'mymaskdata.asn'
 );

=head2 Creating a BLAST database

There are several options for creating the database de novo using
attached data, both before and after factory construction. If a
temporary database (one that can be deleted by the C<cleanup()>
method) is desired, leave out the C<-db_name> parameter. If
C<-db_name> is specified, the database will be preserved with the
basename specified.

Use C<-create => 1> to create a new database (otherwise the factory
will look for an existing database). Use C<-overwrite => 1> to create
and overwrite an existing database.

Note that the database is not created immediately on factory
construction. It will be created if necessary on the first use of a
factory BLAST method, or you can force database creation by executing

 $fac->make_db();

=over

=item * Specify data during construction

With a FASTA file:

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb',
   -db_data => 'myseqs.fas',
   -create => 1
 );

With another BioPerl object collection:

 $alnio = Bio::AlignIO->new( -file => 'alignment.msf' );
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb',
   -db_data => $alnio,
   -create => 1
 );
 @seqs = $alnio->next_aln->each_seq;
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'mydb',
   -db_data => \@seqs,
   -create => 1
 );

Other collections (e.g., L<Bio::SeqIO>) are valid. If a certain type
does not work, please submit an enhancement request.

To create temporary databases, leave out the C<-db_name>, e.g.

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_data => 'myseqs.fas',
   -create => 1
 );

To get the tempfile basename, do:

 $dbname = $fac->db;

=item * Specify data post-construction

Use the explict attribute setters:

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -create => 1
 );

 $fac->set_db_data('myseqs.fas');
 $fac->make_db;

=back

=head2 Creating and using mask data

The blast+ mask utilities C<windowmasker>, C<segmasker>, and
C<dustmasker> are available. Masking can be rolled into database
creation, or can be executed later. If your mask data is already
created and in ASN1 format, set the C<-mask_file> attribute on
construction (see L</Factory constuction/initialization>).

To create a mask from raw data or an existing database and apply the
mask upon database creation, construct the factory like so:

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'my_masked_db',
   -db_data => 'myseqs.fas',
   -masker => 'dustmasker',
   -mask_data => 'maskseqs.fas',
   -create => 1
 );

The masked database will be created during C<make_db>. 

The C<-mask_data> parameter can be a FASTA filename or any BioPerl
sequence object collection. If the datatype ('nucl' or 'prot') of the
mask data is not compatible with the selected masker, an exception
will be thrown with a message to that effect.

To create a mask ASN1 file that can be used in the C<-mask_file>
parameter separately from the attached database, use the
C<make_mask()> method directly:

 $mask_file = $fac->make_mask(-data => 'maskseqs.fas',
                              -masker => 'dustmasker');
 # segmasker can use a blastdb as input
 $mask_file = $fac->make_mask(-mask_db => 'mydb',
                              -masker => 'segmasker')

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'my_masked_db',
   -db_data => 'myseqs.fas',
   -mask_file => $mask_file
   -create => 1
 );   

=head2 Getting database information

To get a hash containing useful metadata on an existing database
(obtained by running C<blastdbcmd -info>, use C<db_info()>:
 
 # get info on the attached database..
 $info = $fac->db_info;
 # get info on another database
 $info = $fac->db_info('~/home/blastdbs/another');

To get a particular info element for the attached database, just call
the element name off the factory:

 $num_seqs = $fac->db_num_sequences;
 # info on all the masks applied to the db, if any:
 @masking_info = @{ $fac->db_filter_algorithms };

=head2 Accessing the L<Bio::Tools::Run::BlastPlus> factory

The blast+ programs are actually executed by a
L<Bio::Tools::Run::BlastPlus> wrapper instance. This instance is
available for peeking and poking in the L<StandAloneBlastPlus>
C<factory()> attribute. For convenience, C<BlastPlus> methods can be
run from the C<StandAloneBlastPlus> object, and are delegated to the
C<factory()> attribute. For example, to get the blast+ program to be
executed, examine either

 $fac->factory->command

or 

 $fac->command

Similarly, the current parameters for the C<BlastPlus> factory are

 @parameters = $fac->get_parameters

=head2 Cleaning up temp files

Temporary analysis files produced under a single factory instances can
be unlinked by running

 $fac->cleanup;

Tempfiles are generally not removed unless this method is explicitly
called. C<cleanup()> only unlinks "registered" files and
databases. All temporary files are automatically registered; in
particular, "anonymous" databases (such as

 $fac->Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_data => 'myseqs.fas', 
   -create => 1
 );

without a C<-db_name> specification) are registered for cleanup. Any
file or database can be registered with an internal method:

 $fac->_register_temp_for_cleanup('testdb');

=head2 Other Goodies

=over

=item

You can check whether a given basename points to a properly formatted
BLAST database by doing

 $is_good = $fac->check_db('putative_db');

=item

User parameters can be passed to the underlying blast+ programs (if
you know what you're doing) with C<db_make_args> and C<mask_make_args>:

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => 'customdb',
   -db_data => 'myseqs.fas', 
   -db_make_args => [ '-taxid_map' => 'seq_to_taxa.txt' ],
   -masker => 'windowmasker',
   -mask_data => 'myseqs.fas',
   -mask_make_args => [ '-dust' => 'T' ],
   -create => 1
 );

=item

You can prevent exceptions from being thrown by failed blast+ program
executions by setting C<no_throw_on_crash>. Examine the error with
C<stderr()>:

 $fac->no_throw_on_crash(1);
 $fac->make_db;
 if ($fac->stderr =~ /Error:/) {
    #handle error
    ...
 }

=back

=head1 SEE ALSO

L<Bio::Tools::Run::StandAloneBlastPlus::BlastMethods>,
L<Bio::Tools::Run::BlastPlus>

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Mark A. Jensen

Email maj -at- fortinbras -dot- us

=head1 CONTRIBUTORS

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::StandAloneBlastPlus;
use strict;
our $AUTOLOAD;

# Object preamble - inherits from Bio::Root::Root

use lib '../../..';
use Bio::Root::Root;
use Bio::SeqIO;
use Bio::Tools::GuessSeqFormat;
use Bio::Tools::Run::StandAloneBlastPlus::BlastMethods;
use File::Temp 0.22;
use IO::String;

use base qw(Bio::Root::Root);
unless ( eval "require Bio::Tools::Run::BlastPlus" ) {
    Bio::Root::Root->throw("This module requires 'Bio::Tools::Run::BlastPlus'");
}

my %AVAILABLE_MASKERS = (
    'windowmasker' => 'nucl',
    'dustmasker'   => 'nucl',
    'segmasker'    => 'prot'
    );

my %MASKER_ENCODING = (
    'windowmasker' => 'maskinfo_asn1_text',
    'dustmasker'   => 'maskinfo_asn1_text',
    'segmasker'    => 'maskinfo_asn1_text'
    );
    
my $bp_class = 'Bio::Tools::Run::BlastPlus';

# what's the desire here?
#
# * factory object (created by new())
#   - points to some blast db entity, so all functions run off the
#     the factory (except bl2seq?) use the associated db
# 
# * create a blast formatted database:
#   - specify a file, or an AlignI object
#   - store for later, or store in a tempfile to throw away
#   - object should store its own database pointer
#   - provide masking options based on the maskers provided
#
# * perform database actions via db-oriented blast+ commands
#   via the object
#
# * perform blast searches against the database
#   - blastx, blastp, blastn, tblastx, tblastn
#   - specify Bio::Seq objects or files as queries
#   - output the results as a file or as a Bio::Search::Result::BlastResult
# * perform 'special' (i.e., ones I don't know) searches
#   - psiblast, megablast, rpsblast, rpstblastn
#     some of these are "tasks" under particular programs
#     check out psiblast, why special (special 'iteration' handling in 
#     ...::BlastResult)
#     check out rpsblast, megablast
#
# * perform bl2seq
#   - return the alignment directly as a convenience, using Bio::Search 
#     functions

# lazy db formatting: makeblastdb only on first blast request...
# ParameterBaseI delegation : use AUTOLOAD
#
# 

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::StandAloneBlastPlus();
 Function: Builds a new Bio::Tools::Run::StandAloneBlastPlus object
 Returns : an instance of Bio::Tools::Run::StandAloneBlastPlus
 Args    : named argument (key => value) pairs:
           -db : blastdb name

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($db_name, $db_data, $db_dir, $db_make_args,
	$mask_file, $mask_data, $mask_make_args, $masker, 
	$create, $overwrite, $is_remote, $prog_dir, $program_dir) 
                 = $self->_rearrange([qw( 
                                          DB_NAME
                                          DB_DATA
                                          DB_DIR
                                          DB_MAKE_ARGS
                                          MASK_FILE 
                                          MASK_DATA
                                          MASK_MAKE_ARGS
                                          MASKER
                                          CREATE
                                          OVERWRITE
                                          REMOTE
                                          PROG_DIR
                                          PROGRAM_DIR
                                           )], @args);

    # parm taint checks
    if ($db_name) {
	$self->throw("DB name contains invalid characters") unless $db_name =~ m{^[a-z0-9_/:.+-]+$}i;
    }

    if ( $db_dir ) { 
	$self->throw("DB directory (DB_DIR) not found") unless (-d $db_dir);
	$self->{'_db_dir'} = $db_dir;
    }
    else {
	$self->{'_db_dir'} = '.';
    }
    $program_dir ||= $prog_dir; # alias
    # now handle these systematically (bug #3003)
    # allow db_name to include path info
    # let db_dir act as root if present and db_name is a relative path
    # db property contains the pathless name only
    if ($db_name) {
	my ($v,$d,$f) = File::Spec->splitpath($db_name);
	$self->throw("No DB name at the end of path '$db_name'") unless $f;
	$f =~ s/\..*$//; # tolerant of extensions, but ignore them
	$self->{_db} = $f;
	# now establish db_path property as the internal authority on 
	# db location...
	if ( File::Spec->file_name_is_absolute($db_name) ) {
	    $self->throw("Path specified in DB name ('$d') does not exist") unless !$d || (-d $d);
	    $self->{_db_path} = File::Spec->catfile($d,$f);
	    $self->{_db_dir} = $d;
	    # ignore $db_dir, give heads-up
	    $self->warn("DB name is an absolute path; setting db_dir to '".$self->db_dir."'") if $db_dir;
	}
	else {
	    $d = File::Spec->catdir($self->db_dir, $d);
	    $self->throw("Path specified by DB_DIR+DB_NAME ('$d') does not exist") unless !$d || (-d $d);
	    $self->{_db_path} = File::Spec->catfile($d,$f);
	}
    }
	
    if ($masker) {
	$self->throw("Masker '$masker' not available") unless 
	    grep /^$masker$/, keys %AVAILABLE_MASKERS;
	$self->{_masker} = $masker;
    }
    
    if ($program_dir) {
	$self->throw("Can't find program directory '$program_dir'") unless
	    -d $program_dir;
	$self->{_program_dir} = $program_dir;
    }
    elsif ($ENV{BLASTPLUSDIR}) {
	$self->{_program_dir} = $ENV{BLASTPLUSDIR};
    }
    $Bio::Tools::Run::BlastPlus::program_dir = $self->{_program_dir} || 
	$Bio::Tools::Run::BlastPlus::program_dir;	
	

    $self->set_db_make_args( $db_make_args) if ( $db_make_args );
    $self->set_mask_make_args( $mask_make_args) if ($mask_make_args);
    $self->{'_create'} = $create;
    $self->{'_overwrite'} = $overwrite;
    $self->{'_is_remote'} = $is_remote;
    $self->{'_db_data'} = $db_data;
    
    $self->{'_mask_file'} = $mask_file;
    $self->{'_mask_data'} = $mask_data;


    # check db
    if (defined $self->check_db and $self->check_db == 0 and !$self->is_remote) {
	$self->throw("DB '".$self->db."' can't be found. To create, set -create => 1.") unless ($create || $overwrite);
    }
    if (!$self->db) {
	# allow this to pass; catch lazily at make_db...
	if (!$self->db_data) {
	    $self->debug('No database or db data specified. '.
			 'To create a new database, provide '.
			 '-db_data => [fasta|\@seqs|$seqio_object]')
	}

	# no db specified; create temp db
	$self->{_create} = 1;
	if ($self->db_dir) {
	    my $fh = File::Temp->new(TEMPLATE => 'DBXXXXX',
				     DIR => $self->db_dir,
				     UNLINK => 1);
	    my ($v,$d,$f) = File::Spec->splitpath($fh->filename);
	    $self->{_db} = $f;
	    $self->{_db_path} = $fh->filename;
	    $self->_register_temp_for_cleanup($self->db_path);
	    $fh->close;
	}
	else {
	    $self->{_db_dir} = File::Temp->newdir('DBDXXXXX');
	    $self->{_db} = 'DBTEMP';
	    $self->{_db_path} = File::Spec->catfile($self->db_dir, 
						    $self->db);
	}
    }

    return $self;
}

=head2 db()

 Title   : db
 Usage   : $obj->db($newval)
 Function: contains the basename of the local blast database
 Example : 
 Returns : value of db (a scalar string)
 Args    : readonly

=cut

sub db { shift->{_db} }
sub db_name { shift->{_db} }
sub set_db_name { shift->{_db} = shift }
sub db_dir { shift->{_db_dir} }
sub set_db_dir { shift->{_db_dir} = shift }
sub db_path { shift->{_db_path} }
sub db_data { shift->{_db_data} }
sub set_db_data { shift->{_db_data} = shift }
sub db_type { shift->{_db_type} }
sub masker { shift->{_masker} }
sub set_masker { shift->{_masker} = shift }
sub mask_file { shift->{_mask_file} }
sub set_mask_file { shift->{_mask_file} = shift }
sub mask_data { shift->{_mask_data} }
sub set_mask_data { shift->{_mask_data} = shift }

=head2 factory()

 Title   : factory
 Usage   : $obj->factory($newval)
 Function: attribute containing the Bio::Tools::Run::BlastPlus 
           factory
 Example : 
 Returns : value of factory (Bio::Tools::Run::BlastPlus object)
 Args    : readonly

=cut

sub factory { shift->{_factory} }
sub create { shift->{_create} }
sub overwrite { shift->{_overwrite} }
sub is_remote { shift->{_is_remote} }

=head2 program_version()

 Title   : program_version
 Usage   : $version = $bedtools_fac->program_version()
 Function: Returns the program version (if available)
 Returns : string representing location and version of the program
 Note    : this works around the WrapperBase::version() method conflicting with
           the -version parameter for SABlast (good argument for not having
           getter/setters for these)

=cut

=head2 package_version()

 Title   : package_version
 Usage   : $version = $bedtools_fac->package_version()
 Function: Returns the BLAST+ package version (if available)
 Returns : string representing BLAST+ package version (may differ from version())

=cut

sub program_version {
    my $self = shift;
    my $fac = $self->factory;
    $fac->program_version(@_) if $fac;
}

sub package_version {
    my $self = shift;
    my $fac = $self->factory;
    $fac->package_version(@_) if $fac;
}

=head1 DB methods

=head2 make_db()

 Title   : make_db
 Usage   : 
 Function: create the blast database (if necessary), 
           imposing masking if specified
 Returns : true on success
 Args    : 

=cut

# should also provide facility for creating subdatabases from 
# existing databases (i.e., another format for $data: the name of an
# existing blastdb...)
sub make_db {
    my $self = shift;
    my @args = @_;
    return 1 if ( $self->check_db && !$self->overwrite ); # already there or force make

    $self->throw('No database or db data specified. '.
		 'To create a new database, provide '.
		 '-db_data => [fasta|\@seqs|$seqio_object]') 
	unless $self->db_data;
    # db_data can be: fasta file, array of seqs, Bio::SeqIO object
    my $data = $self->db_data;
    $data = $self->_fastize($data);
    my $testio = Bio::SeqIO->new(-file=>$data, -format=>'fasta');
    $self->{_db_type} = ($testio->next_seq->alphabet =~ /.na/) ? 'nucl' : 'prot';
    $testio->close;

    my ($v,$d,$name) = File::Spec->splitpath($data);
    $name =~ s/\.fas$//;
    $self->{_db} ||= $name;
    $self->{_db_path} = File::Spec->catfile($self->db_dir,$self->db);
    # <#######[
    # deal with creating masks here, 
    # and provide correct parameters to the 
    # makeblastdb ...
    
    # accomodate $self->db_make_args here -- allow them
    # to override defaults, or allow only those args
    # that are not specified here?
    my $usr_db_args ||= $self->db_make_args;
    my %usr_args = @$usr_db_args if $usr_db_args;

    my %db_args = (
	-in => $data,
	-dbtype => $self->db_type,
	-out => $self->db_path,
	-title => $self->db,
	-parse_seqids => 1 # necessary for masking
	);
    # usr arg override
    if (%usr_args) {
	$db_args{$_} = $usr_args{$_} for keys %usr_args;
    }

    # do masking if requested
    # if the (masker and mask_data) OR mask_file attributes of this
    # object are set, assume that masking is desired
    # 
    if ($self->mask_file) { # the actual masking data is provided
	$db_args{'-mask_data'} = $self->mask_file;
    }
    elsif ($self->masker && $self->mask_data) { # build the mask
	$db_args{'-mask_data'} = $self->make_mask(-data => $self->mask_data);
	$self->throw("Masker error: message is '".$self->stderr."'") unless
	    $db_args{'-mask_data'};
	$self->{_mask_data} = $db_args{'-mask_data'};
    }

    $self->{_factory} = $bp_class->new(
	-command => 'makeblastdb',
	%db_args
	);
    $self->factory->no_throw_on_crash($self->no_throw_on_crash);    
    return $self->factory->_run;
}

=head2 make_mask()

 Title   : make_mask
 Usage   : 
 Function: create masking data based on specified parameters
 Returns : mask data filename (scalar string)
 Args    : 

=cut

# mask program usage (based on blast+ manual)
# 
# program        dbtype        opn
# windowmasker   nucl          mask overrep data, low-complexity (optional)
# dustmasker     nucl          mask low-complexity
# segmasker      prot  

sub make_mask {
    my $self = shift;
    my @args = @_;
    my ($data, $mask_db, $make_args, $masker) = $self->_rearrange([qw(
                                                            DATA
                                                            MASK_DB
                                                            MAKE_ARGS
                                                            MASKER)], @args);
    my (%mask_args,%usr_args,$db_type);
    my $infmt = 'fasta';
    $self->throw("make_mask requires -data argument") unless $data;
    $masker ||= $self->masker;
    $self->throw("no masker specified and no masker default set in object") 
	unless $masker;
    my $usr_make_args ||= $self->mask_make_args;
    %usr_args = @$usr_make_args if $usr_make_args;
    unless (grep /^$masker$/, keys %AVAILABLE_MASKERS) {
	$self->throw("Masker '$masker' not available");
    }
    if ($self->check_db($data)) {
	unless ($masker eq 'segmasker') {
	    $self->throw("Masker '$masker' can't use a blastdb as primary input");
	}
	unless ($self->db_info($data)->{_db_type} eq 
		$AVAILABLE_MASKERS{$masker}) {
	    $self->throw("Masker '$masker' is incompatible with input db sequence type");
	}
	$infmt = 'blastdb';
    }
    else {
	$data = $self->_fastize($data);
	my $sio = Bio::SeqIO->new(-file=>$data);
	my $s = $sio->next_seq;
	my $type;
	if ($s->alphabet =~ /.na/) {
	    $type = 'nucl';
	}
	elsif ($s->alphabet =~ /protein/) {
	    $type = 'prot';
	}
	else {
	    $type = 'UNK';
	}
	unless ($type eq $AVAILABLE_MASKERS{$masker}) {
	    $self->throw("Masker '$masker' is incompatible with sequence type '$type'");
	}
    }
    
    # check that sequence type and masker program match:
    
    # now, need to provide reasonable default masker arg settings, 
    # and override these with $usr_make_args as necessary and appropriate
    my $mh = File::Temp->new(TEMPLATE=>'MSKXXXXX',
			     UNLINK => 0,
			     DIR => $self->db_dir);
    my $mask_outfile = $mh->filename;
    $mh->close;
    $self->_register_temp_for_cleanup(File::Spec->catfile($self->db_dir,$mask_outfile));

    %mask_args = (
	-in => $data,
	-parse_seqids => 1,
	#-outfmt => $MASKER_ENCODING{$masker}
	);
    # usr arg override
    if (%usr_args) {
	$mask_args{$_} = $usr_args{$_} for keys %usr_args;
    }
    # masker-specific pipelines
    my $status;
    for ($masker) {
	m/dustmasker/ && do {
	    $mask_args{'-out'} = $mask_outfile;
	    $self->{_factory} = $bp_class->new(-command => $masker,
					       %mask_args);
	    $self->factory->no_throw_on_crash($self->no_throw_on_crash);
	    $status = $self->factory->_run;
	    last;
	};
	m/windowmasker/ && do {
	    # check mask_db if present
	    if ($mask_db) {
		unless ($self->check_db($mask_db)) {
		    $self->throw("Mask database '$mask_db' is not present or valid");
		}
	    }
	    my $cth = File::Temp->new(TEMPLATE=>'MCTXXXXX',
				      DIR => $self->db_dir);
	    my $ct_file = $cth->filename;
	    $cth->close;
	    $mask_args{'-out'} = $ct_file;
	    $mask_args{'-mk_counts'} = 'true';
	    $self->{_factory} = $bp_class->new(-command => $masker,
					       %mask_args);
	    $self->factory->no_throw_on_crash($self->no_throw_on_crash);
	    $status = $self->factory->_run;
	    last unless $status;
	    delete $mask_args{'-mk_counts'};
	    $mask_args{'-ustat'} = $ct_file;
	    $mask_args{'-out'} = $mask_outfile;
	    if ($mask_db) {
		$mask_args{'-in'} = $mask_db;
		$mask_args{'-infmt'} = 'blastdb';
	    }
	    $self->factory->reset_parameters(%mask_args);
	    $self->factory->no_throw_on_crash($self->no_throw_on_crash);
	    $status = $self->factory->_run;
	    last;
	};
	m/segmasker/ && do {
	    $mask_args{'-infmt'} = $infmt;
	    $mask_args{'-out'} = $mask_outfile;
	    $self->{_factory} = $bp_class->new(-command => $masker,
					       %mask_args);
	    $self->factory->no_throw_on_crash($self->no_throw_on_crash);
	    $status = $self->factory->_run;
	    last;
	};
	do {
	    $self->throw("Masker program '$masker' not recognized");
	};
    }
    return $status ? $mask_outfile : $status;
}

=head2 db_info()

 Title   : db_info
 Usage   : 
 Function: get info for database 
           (via blastdbcmd -info); add factory attributes
 Returns : hash of database attributes
 Args    : [optional] db name (scalar string) (default: currently attached db)

=cut

sub db_info {
    my $self = shift;
    my $db = shift;
    $db ||= $self->db_path;
    unless ($db) {
	$self->warn("db_info: db not specified and no db attached");
	return;
    }
    if ($self->is_remote) {
	$self->warn("db_info: sorry, can't get info for remote database (complain to NCBI)");
	return;
    }
    if ($db eq $self->db and $self->{_db_info}) {
	return $self->{_db_info}; # memoized
    }
    my $db_info_text;
    $self->{_factory} = $bp_class->new( -command => 'blastdbcmd',
					-info => 1,
					-db => $db );
    $self->factory->no_throw_on_crash(1);
    $self->factory->_run();
    $self->factory->no_throw_on_crash(0);
    if ($self->factory->stderr =~ /No alias or index file found/) {
	$self->warn("db_info: Couldn't find database ".$self->db."; make with make_db()");
	return;
    }
    $db_info_text = $self->factory->stdout;
    # parse info into attributes
    my $infh = IO::String->new($db_info_text);
    my %attr;
    while (<$infh>) {
	/Database: (.*)/ && do {
	    $attr{db_info_name} = $1;
	    next;
	};
	/([0-9,]+) sequences; ([0-9,]+) total/ && do {
	    $attr{db_num_sequences} = $1;
	    $attr{db_total_bases} = $2;
	    $attr{db_num_sequences} =~ s/,//g;
	    $attr{db_total_bases} =~ s/,//g;
	    next;
	};
	/Date: (.*?)\s+Longest sequence: ([0-9,]+)/ && do {
	    $attr{db_date} = $1; # convert to more usable date object
	    $attr{db_longest_sequence} = $2;
	    $attr{db_longest_sequence} =~ s/,//g;
	    next;
	};
	/Algorithm ID/ && do {
	    my $alg = $attr{db_filter_algorithms} = [];
	    while (<$infh>) {
		if (/\s+([0-9]+)\s+([a-z0-9_]+)\s+(.*)/i) {
		    push @$alg, { algorithm_id => $1,
				  algorithm_name => $2,
				  algorithm_opts => $3 };
		}
		else {
		    last;
		}
	    }
	    next;
	};
    }
    # get db type
    if ( -e $db.'.psq' ) {
	$attr{_db_type} = 'prot';
    }
    elsif (-e $db.'.nsq') {
	$attr{_db_type} = 'nucl';
    }
    else {
	$attr{_db_type} = 'UNK'; # bork
    }
    if ($db eq $self->db) {
	$self->{_db_type} = $attr{_db_type};
	$self->{_db_info_text} = $db_info_text;
	$self->{_db_info} = \%attr;
    }
    return \%attr;
}

=head2 set_db_make_args()

 Title   : set_db_make_args
 Usage   : 
 Function: set the DB make arguments attribute 
           with checking
 Returns : true on success
 Args    : arrayref or hashref of named arguments

=cut

sub set_db_make_args {
    my $self = shift;
    my $args = shift;
    $self->throw("Arrayref or hashref required at DB_MAKE_ARGS") unless 
	ref($args) =~ /^ARRAY|HASH$/;
    if (ref($args) eq 'HASH') {
	my @a = %$args;
	$args = \@a;
    }
    $self->throw("Named args required for DB_MAKE_ARGS") unless !(@$args % 2);
    $self->{'_db_make_args'} = $args;
    return 1;
}

sub db_make_args { shift->{_db_make_args} }

=head2 set_mask_make_args()

 Title   : set_mask_make_args
 Usage   : 
 Function: set the masker make arguments attribute
           with checking
 Returns : true on success
 Args    : arrayref or hasref of named arguments

=cut

sub set_mask_make_args {
    my $self = shift;
    my $args = shift;
    $self->throw("Arrayref or hashref required at MASK_MAKE_ARGS") unless 
	ref($args) =~ /^ARRAY|HASH$/;
    if (ref($args) eq 'HASH') {
	my @a = %$args;
	$args = \@a;
    }
    $self->throw("Named args required at MASK_MAKE_ARGS") unless !(@$args % 2);
    $self->{'_mask_make_args'} = $args;
    return 1;
}

sub mask_make_args { shift->{_mask_make_args} }

=head2 check_db()

 Title   : check_db
 Usage   : 
 Function: determine if database with registered name and dir
           exists
 Returns : 1 if db present, 0 if not present, undef if name/dir not
           set
 Args    : [optional] db name (default is 'registered' name in $self->db)
           [optional] db directory (default is 'registered' dir in 
                                    $self->db_dir)

=cut

sub check_db {
    my $self = shift;
    my ($db) = @_;
    my $db_path;
    if ($db) {
	my ($v,$d,$f) = File::Spec->splitpath($db);
	$f =~ s/\..*$//; # ignore extensions
	$db_path = File::Spec->catfile($d||'.',$f);
    }
    else {
	$db_path = $self->db_path;
    }
    if ( $db_path ) {
	$self->{_factory} = $bp_class->new( -command => 'blastdbcmd',
					    -info => 1,
					    -db => $db_path );
#	$DB::single=1;
	$self->factory->no_throw_on_crash(1);
	$self->factory->_run();
	$self->factory->no_throw_on_crash(0);
	return 0 if ($self->factory->stderr =~ /No alias or index file found/);
	return 1;
    }
    return;
}

=head2 no_throw_on_crash()

 Title   : no_throw_on_crash
 Usage   : $fac->no_throw_on_crash($newval)
 Function: set to prevent an exeception throw on a failed 
           blast program execution
 Example : 
 Returns : value of no_throw_on_crash (boolean)
 Args    : on set, new value (boolean)

=cut

sub no_throw_on_crash {
    my $self = shift;
    
    return $self->{'no_throw_on_crash'} = shift if @_;
    return $self->{'no_throw_on_crash'};
}


=head1 Internals

=head2 _fastize()

 Title   : _fastize
 Usage   : 
 Function: convert a sequence collection to a temporary
           fasta file (sans gaps)
 Returns : fasta filename (scalar string)
 Args    : sequence collection 

=cut

sub _fastize {
    my $self = shift;
    my $data = shift;
    for ($data) {
	!ref && do {
	    # suppose a fasta file name
	    $self->throw('Sequence file not found') unless -e $data;
	    my $guesser = Bio::Tools::GuessSeqFormat->new(-file => $data);
	    $self->throw('Sequence file not in FASTA format') unless
		$guesser->guess eq 'fasta';
	    last;
	};
	(ref eq 'ARRAY') && (ref $$data[0]) &&
	    ($$data[0]->isa('Bio::Seq') || $$data[0]->isa('Bio::PrimarySeq'))
	    && do {
		my $fh = File::Temp->new(TEMPLATE => 'DBDXXXXX', 
					 UNLINK => 0, 
					 DIR => $self->db_dir,
					 SUFFIX => '.fas');
		my $fname = $fh->filename;
		$fh->close;
		$self->_register_temp_for_cleanup($fname);
		my $fasio = Bio::SeqIO->new(-file=>">$fname", -format=>"fasta")
		   or $self->throw("Can't create temp fasta file");
		for (@$data) {
		    my $s = $_->seq;
		    my $a = $_->alphabet;
		    $s =~ s/[$Bio::PrimarySeq::GAP_SYMBOLS]//g;
		    $_->seq( $s );
		    $_->alphabet($a);
		    $fasio->write_seq($_);
		}
		$fasio->close;
		$data = $fname;
		last;
	};
	ref && do { # some kind of object
	    my ($fmt) = ref($data) =~ /.*::(.*)/;
	    if ($fmt eq 'fasta') {
		$data = $data->file; # use the fasta file directly
	    }
	    else {
		# convert
		my $fh = File::Temp->new(TEMPLATE => 'DBDXXXXX', 
					 UNLINK => 0, 
					 DIR => $self->db_dir,
					 SUFFIX => '.fas');
		my $fname = $fh->filename;
		$fh->close;
		$self->_register_temp_for_cleanup($fname);
		my $fasio = Bio::SeqIO->new(-file=>">$fname", -format=>"fasta") 
		    or $self->throw("Can't create temp fasta file");
		require Bio::PrimarySeq;
		if ($data->isa('Bio::AlignIO')) {
		    my $aln = $data->next_aln;
		    for ($aln->each_seq) {
			# must de-gap
			my $s = $_->seq;
			my $a = $_->alphabet;
			$s =~ s/[$Bio::PrimarySeq::GAP_SYMBOLS]//g;
			$_->seq( $s );
			$_->alphabet($a);
			$fasio->write_seq($_) 
		    }
		}
		elsif ($data->isa('Bio::SeqIO')) {
		    while (local $_ = $data->next_seq) {
			my $s = $_->seq;
			my $a = $_->alphabet;
			$s =~ s/[$Bio::PrimarySeq::GAP_SYMBOLS]//g;
			$_->seq( $s );
			$_->alphabet($a);
			$fasio->write_seq($_);
		    }
		}
		elsif ($data->isa('Bio::Align::AlignI')) {
		    for( $data->each_seq) {
			my $s = $_->seq;
			my $a = $_->alphabet;
			$s =~ s/[$Bio::PrimarySeq::GAP_SYMBOLS]//g;
			$_->seq( $s );
			$_->alphabet($a);
			$fasio->write_seq($_) 
		    }
		}
		elsif ($data->isa('Bio::Seq') || $data->isa('Bio::PrimarySeq')) {
		    my $s = $data->seq;
		    my $a = $data->alphabet;
		    $s =~ s/[$Bio::PrimarySeq::GAP_SYMBOLS]//g;
		    $data->seq($s);
		    $data->alphabet($a);
		    $fasio->write_seq($data);
		}
		else {
		    $self->throw("Can't handle sequence container object ".
				 "of type '".ref($data)."'");
		}
		$fasio->close;
		$data = $fname;
	    }
	    last;
	};
    }
    return $data;
}

=head2 _register_temp_for_cleanup()

 Title   : _register_temp_for_cleanup
 Usage   : 
 Function: register a file for cleanup with 
           cleanup() method
 Returns : true on success
 Args    : a file name or a blastdb basename
           (scalar string)

=cut

sub _register_temp_for_cleanup {
    my $self = shift;
    my @files = @_;

    for (@files) {
	my ($v, $d, $n) = File::Spec->splitpath($_);
	$_ = File::Spec->catfile($self->db_dir, $n) unless length($d);
	push @{$self->{_cleanup_list}}, File::Spec->rel2abs($_);
    }
    return 1;
}

=head2 cleanup()

 Title   : cleanup
 Usage   : 
 Function: unlink files registered for cleanup
 Returns : true on success
 Args    : 

=cut

sub cleanup {
    my $self = shift;
    return unless $self->{_cleanup_list};
    for (@{$self->{_cleanup_list}}) {
	m/(\.[a-z0-9_]+)+$/i && do {
	    unlink $_;
	    next;
	};
	do { # catch all index files
	    if ( -e $_.".psq" ) {
		unlink glob($_.".p*");
		unlink glob($_.".??.p*");
	    }
	    elsif ( -e $_.".nsq" ) {
		unlink glob($_.".n*");
		unlink glob($_.".??.n*");
	    }
	    else {
		unlink $_;
	    }
	    next;
	};
    }
    return 1;
}

=head2 AUTOLOAD

In this module, C<AUTOLOAD()> delegates L<Bio::Tools::Run::WrapperBase> and
L<Bio::Tools::Run::WrapperBase::CommandExts> methods (including those
of L<Bio::ParamterBaseI>) to the C<factory()> attribute:

 $fac->stderr

gives you

 $fac->factory->stderr

If $AUTOLOAD isn't pointing to a WrapperBase method, then AUTOLOAD attempts to return a C<db_info> attribute: e.g.

 $fac->db_num_sequences

works by looking in the $fac->db_info() hash.

Finally, if $AUTOLOAD is pointing to a blast query method, AUTOLOAD
runs C<run> with the C<-method> parameter appropriately set.

=cut 

sub AUTOLOAD {
    my $self = shift;
    my @args = @_;
    my $method = $AUTOLOAD;
    $method =~ s/.*:://;
    my @ret;
    if (grep /^$method$/, @Bio::Tools::Run::StandAloneBlastPlus::BlastMethods) {
	push @args, ('-method_args' => ['-remote' => 1] ) if ($self->is_remote);
	return $self->run( -method => $method, @args );
    }
    if ($self->factory and $self->factory->can($method)) { # factory method
	return $self->factory->$method(@args);
    }
    if ($self->db_info and grep /^$method$/, keys %{$self->db_info}) {
	return $self->db_info->{$method};
    }
    # else, fail
    $self->throw("Can't locate method '$method' in class ".ref($self));

}


1;
