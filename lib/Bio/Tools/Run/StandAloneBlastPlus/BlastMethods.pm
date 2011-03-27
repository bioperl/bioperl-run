# $Id$
#
# BioPerl module for Bio::Tools::Run::StandAloneBlastPlus::BlastMethods
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

Bio::Tools::Run::StandAloneBlastPlus::BlastMethods - Provides BLAST methods to StandAloneBlastPlus

=head1 SYNOPSIS

 # create a factory:
 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
    -db_name => 'testdb'
 );
 # get your results
 $result = $fac->blastn( -query => 'query_seqs.fas',
                         -outfile => 'query.bls',
                         -method_args => [ '-num_alignments' => 10 ,

 $result = $fac->tblastx( -query => $an_alignment_object,
                          -outfile => 'query.bls',
                          -outformat => 7 );
 # do a bl2seq
 $fac->bl2seq( -method => 'blastp',
               -query => $seq_object_1,
               -subject => $seq_object_2 );

=head1 DESCRIPTION

This module provides the BLAST methods (blastn, blastp, psiblast,
etc.) to the L<Bio::Tools::Run::StandAloneBlastPlus> object.

=head1 USAGE

This POD describes the use of BLAST methods against a
L<Bio::Tools::Run::StandAloneBlastPlus> factory object. The object
itself has extensive facilities for creating, formatting, and masking
BLAST databases; please refer to
L<Bio::Tools::Run::StandAloneBlastPlus> POD for these details.

Given a C<StandAloneBlastPlus> factory, such as

 $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
    -db_name => 'testdb'
 );

you can run the desired BLAST method directly from the factory object,
against the database currently attached to the factory (in the
example, C<testdb>). C<-query> is a required argument:

 $result = $fac->blastn( -query => 'query_seqs.fas' );

Here, C<$result> is a L<Bio::Search::Result::BlastResult> object.

Other details:

=over

=item * The blast output file can be named explicitly:

 $result = $fac->blastn( -query => 'query_seqs.fas',
                         -outfile => 'query.bls' );

=item * The output format can be specified:

 $result = $fac->blastn( -query => 'query_seqs.fas',
                         -outfile => 'query.bls',
                         -outformat => 7 ); #tabular

=item * Additional arguments to the method can be specified:

 $result = $fac->blastn( -query => 'query_seqs.fas',
                         -outfile => 'query.bls',
                         -method_args => [ '-num_alignments' => 10 ,
                                           '-evalue' => 100 ]);

=item * To get the name of the blast output file, do 

 $file = $fac->blast_out;

=item * To clean up the temp files (you must do this explicitly):

 $fac->cleanup;

=back

=head2 bl2seq()

Running C<bl2seq> is similar, but both C<-query> and C<-subject> are
required, and the attached database is ignored. The blast method must
be specified explicitly with the C<-method> parameter:

 $fac->bl2seq( -method => 'blastp',
               -query => $seq_object_1,
               -subject => $seq_object_2 );

Other parameters ( C<-method_args>, C<-outfile>, and C<-outformat> ) are valid. 

=head2 Return values

The return value is always a L<Bio::Search::Result::BlastResult>
object on success, undef on failure.

=head1 SEE ALSO

L<Bio::Tools::Run::StandAloneBlastPlus>, L<Bio::Tools::Run::BlastPlus>

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

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...

# note: providing methods directly to the namespace...
package Bio::Tools::Run::StandAloneBlastPlus;
use strict;
use warnings;

use Bio::SearchIO;
use lib '../../../..';
use Bio::Tools::Run::BlastPlus;
use File::Temp;
use File::Copy;
use File::Spec;
our @BlastMethods = qw( blastp blastn blastx tblastn tblastx 
                       psiblast rpsblast rpstblastn );

=head2 run()

 Title   : run
 Usage   : 
 Function: Query the attached database using a specified blast
           method
 Returns : Bio::Search::Result::BlastResult object
 Args    : key => value:
           -method => $method [blastp|blastn|blastx|tblastx|tblastn|
                               rpsblast|psiblast|rpstblastn]
           -query => $query_sequences (a fasta file name or BioPerl sequence
                      object or sequence collection object)
           -outfile => $blast_report_file (optional: default creates a tempfile)
           -outformat => $format_code (integer in [0..10], see blast+ docs)
           -method_args => [ -key1 => $value1, ... ] (additional arguments
                         for the given method)

=cut

sub run {
    my $self = shift;
    my @args = @_;
    my ($method, $query, $outfile, $outformat, $method_args) = $self->_rearrange( [qw( 
                                         METHOD
                                         QUERY
                                         OUTFILE
                                         OUTFORMAT
                                         METHOD_ARGS
                                         )], @args);
    my $ret;
    my (%blast_args, %usr_args);
    
    unless ($method) {
	$self->throw("Blast run: method not specified, use -method");
    }
    unless ($query) {
	$self->throw("Blast run: query data required, use -query");
    }
    unless ($outfile) { # create a tempfile name
	my $fh = File::Temp->new(TEMPLATE => 'BLOXXXXX',
				 DIR => $self->db_dir,
				 UNLINK => 0);
	$outfile = $fh->filename;
	$fh->close;
	$self->_register_temp_for_cleanup($outfile);
    }
    if ($outformat) { 
	unless ($outformat =~ /^[0-9]{1,2}$/) {
	    $self->throw("Blast run: output format code should be integer 0-10");
	}
	$blast_args{'-outfmt'} = $outformat;
    }

    if ($method_args) {
	$self->throw("Blast run: method arguments must be name => value pairs") unless !(@$method_args % 2);
	%usr_args = @$method_args;
    }
    # make db if necessary
    $self->make_db unless $self->check_db or $self->is_remote or $usr_args{'-subject'} or $usr_args{'-SUBJECT'}; # no db nec if this is bl2seq...
    $self->{_factory} = Bio::Tools::Run::BlastPlus->new( -command => $method );
    if (%usr_args) {
	my @avail_parms = $self->factory->available_parameters('all');
	while ( my( $key, $value ) = each %usr_args ) {
	    $key =~ s/^-//;
	    unless (grep /^$key$/, @avail_parms) {
		$self->throw("Blast run: parameter '$key' is not available for method '$method'");
	    }
	}
    }

    # remove a leading ./ on remote databases. Something adds that in the
    # factory, easier to remove here.
    my $db = $self->db_path;
    if ($self->is_remote) {
        $db =~ s#^\./##;
    }
    $blast_args{-db} = $db;
    $blast_args{-query} = $self->_fastize($query);
    $blast_args{-out} = $outfile;
    # user arg override
    if (%usr_args) {
	$blast_args{$_} = $usr_args{$_} for keys %usr_args;
    }
    # override for bl2seq;
    if ($blast_args{'-db'} && $blast_args{'-subject'}) {
	delete $blast_args{'-db'};
    }
    $self->factory->set_parameters( %blast_args );
    $self->factory->no_throw_on_crash( $self->no_throw_on_crash );
    my $status = $self->_run;

    return $status unless $status;
    # kludge to demodernize the bl2seq output
    if ($blast_args{'-subject'}) {
	unless (_demodernize($outfile)) {
	    $self->throw("Ack! demodernization failed!");
	}
    }

    # if here, success 
    for ($method) {
	m/^(t|psi|rps|rpst)?blast[npx]?/ && do { 
	    $ret = Bio::SearchIO->new(-file => $outfile);

	    $self->{_blastout} = $outfile;
	    $self->{_results} = $ret;
	    $ret = $ret->next_result;
	    last;
	};
	do {
	    1; # huh?
	};
    }
    
    return $ret;
}

=head2 bl2seq()

 Title   : bl2seq
 Usage   : 
 Function: emulate bl2seq using blast+ programs
 Returns : Bio::Search::Result::BlastResult object
 Args    : key => value
           -method => $blast_method [blastn|blastp|blastx|
                                     tblastn|tblastx]
           -query => $query (fasta file or BioPerl sequence object
           -subject => $subject (fasta file or BioPerl sequence object)
           -outfile => $blast_report_file
           -method_args => [ $key1 => $value1, ... ] (additional method 
                        parameters)

=cut

sub bl2seq {
    my $self = shift;
    my @args = @_;
    my ($method, $query, $subject, $outfile, $outformat, $method_args) = $self->_rearrange( [qw( 
                                         METHOD
                                         QUERY
                                         SUBJECT
                                         OUTFILE
                                         OUTFORMAT
                                         METHOD_ARGS
                                         )], @args);

    unless ($method) {
	$self->throw("bl2seq: blast method not specified, use -method");
    }
    unless ($query) {
	$self->throw("bl2seq: query data required, use -query");
    }
    unless ($subject) {
	$self->throw("bl2seq: subject data required, use -subject");
    }
    $subject = $self->_fastize($subject);

    my @run_args;
    if ($method_args) {
	@run_args = @$method_args;
    }
    return $self->run( -method => $method,
		       -query => $query,
		       -outfile => $outfile, 
		       -outformat => $outformat,
		       -method_args => [ @run_args, '-subject' => $subject ]
	);

}

=head2 next_result()

 Title   : next_result
 Usage   : $result = $fac->next_result;
 Function: get the next BLAST result
 Returns : Bio::Search::Result::BlastResult object
 Args    : none

=cut

sub next_result() {
    my $self = shift;
    return unless $self->{_results};
    return $self->{_results}->next_result;
}

=head2 rewind_results()

 Title   : rewind_results
 Usage   : $fac->rewind_results;
 Function: rewind BLAST results
 Returns : true on success
 Args    : 

=cut

sub rewind_results {
    my $self = shift;
    return unless $self->blast_out;
    $self->{_results} = Bio::SearchIO->new( -file => $self->blast_out );
    return 1;
}


=head2 blast_out()

 Title   : blast_out
 Usage   : $file = $fac->blast_out
 Function: get the filename of the blast report file
 Returns : scalar string
 Args    : none

=cut

sub blast_out { shift->{_blastout} }

# =head2 _demodernize()

#  Title   : _demodernize
#  Usage   : 
#  Function: Ha! Wouldn't you like to know!
#  Returns : 
#  Args    : 

# =cut

sub _demodernize {
    my $file = shift;
    my $tf = File::Temp->new();
    open (my $f, $file);
    while (<$f>) {
	s/^Subject=\s+/>/;
	print $tf $_;
    }
    $tf->close;
    copy($tf->filename, $file);
}
1;
