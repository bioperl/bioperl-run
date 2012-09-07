=head1 NAME

Bio::Tools::Run::Phylo::Hyphy::BatchFile - Wrapper for custom execution of Hyphy batch files

=head1 SYNOPSIS

my $aln = Bio::Align::AlignI->new();
my $treeio = Bio::TreeIO->new(-format => "nexus", -file => "$tree_file");
my $tree = $treeio->next_tree();
my $bf_exec = Bio::Tools::Run::Phylo::Hyphy::BatchFile->new(-params => {'bf' => "hyphybatchfile.bf", 'order' => ["Universal", "Custom", $aln, "001001", $tree]});
$bf_exec->set_parameter('3', "012012");
my ($rc,$parser) = $bf_exec->run();

=head1 DESCRIPTION

This module creates a generic interface to processing of HBL files in HyPhy ([Hy]pothesis
Testing Using [Phy]logenies), a package by Sergei Kosakowsky Pond,
Spencer V. Muse, Simon D.W. Frost and Art Poon.  See
http://www.hyphy.org for more information.

Instances of this module require only a link to the batch file and an ordered list of
parameters, as described in the HyPhy documentation "SelectionAnalyses.pdf."


=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Daisie Huang

Email daisieh@zoology.ubc.ca

=head1 CONTRIBUTORS

Additional contributors names and emails here

=cut

package Bio::Tools::Run::Phylo::Hyphy::BatchFile;
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Hyphy::Base;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::Phylo::Hyphy::Base);

=head2 valid_values

 Title   : valid_values
 Usage   : $factory->valid_values()
 Function: returns the possible parameters
 Returns:  an array holding all possible parameters. The default
values are always the first one listed.  These descriptions are
essentially lifted from the python wrapper or provided by the author.
 Args    : None

=cut


sub valid_values {
    return (
        {'geneticCode' => [ "Universal","VertebratemtDNA","YeastmtDNA","Mold/ProtozoanmtDNA",
                         "InvertebratemtDNA","CiliateNuclear","EchinodermmtDNA","EuplotidNuclear",
                         "Alt.YeastNuclear","AscidianmtDNA","FlatwormmtDNA","BlepharismaNuclear"]},
        {'tempalnfile' => undef }, # aln file goes here
        {'temptreefile' => undef }, # tree file goes here
    );
}

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Hyphy::BatchFile->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Hyphy::BatchFile object
 Returns : Bio::Tools::Run::Phylo::Hyphy::BatchFile
 Args    : -alignment => the Bio::Align::AlignI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -tree => the Bio::Tree::TreeI object
           -params => a hashref of parameters (all passed to set_parameter)
                      this hashref should include   'bf' => custombatchfile.bf
                                                    'order' => [array of ordered parameters]
           -executable => where the hyphy executable resides

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>

=cut

sub new {
    my($class,@args) = @_;

    my $self = $class->SUPER::new(@args);
    my ($aln, $tree, $st, $params, $exe) = $self->_rearrange([qw(ALIGNMENT TREE SAVE_TEMPFILES PARAMS EXECUTABLE)], @args);
    defined $aln && $self->alignment($aln);
    defined $tree && $self->tree($tree);
    defined $st  && $self->save_tempfiles($st);
    defined $exe && $self->executable($exe);

    $self->set_default_parameters();
    if( defined $params ) {
        if( ref($params) !~ /HASH/i ) {
            $self->warn("Must provide a valid hash ref for parameter -FLAGS");
        } else {
            map { $self->set_parameter($_, $$params{$_}) } keys %$params;
        }
    }
    return $self;
}

=head2 update_ordered_parameters

 Title   : update_ordered_parameters
 Usage   : $BatchFile->update_ordered_parameters();
 Function: updates all of the parameters needed for the ordered input redirect in HBL.
 Returns : nothing
 Args    : none

=cut

sub update_ordered_parameters {
    my ($self) = @_;
    unless (defined ($self->{'_params'}{'order'})) {
        $self->throw("No ordered parameters for HYPHY were defined.");
    }
    for (my $i=0; $i< scalar @{$self->{'_params'}{'order'}}; $i++) {
        my $item = @{$self->{'_params'}{'order'}}[$i];
        #FIXME: update_ordered_parameters should be more flexible. It should be able to tell what type of object $item is and, if necessary, create a temp file for it.
        if (ref ($item) =~ m/Bio::SimpleAlign/) {
            $item = $self->{'_params'}{'tempalnfile'};
        } elsif (ref ($item) =~ m/Bio::Tree::Tree/) {
            $item = $self->{'_params'}{'temptreefile'};
        }
        $self->{'_orderedparams'}[$i] = {$i, $item};
    }
    $self->SUPER::update_ordered_parameters();
}

=head2 run

 Title   : run
 Usage   : my ($rc,$results) = $BatchFile->run();
 Function: run the Hyphy analysis using the specified batchfile and its ordered parameters
 Returns : Return code, Hash
 Args    : none


=cut

sub run {
    my $self = shift;
    my ($rc, $results) = $self->SUPER::run();
    my $outfile = $self->outfile_name();
    open(OUTFILE, ">", $outfile) or $self->throw("cannot open $outfile for writing");
    print OUTFILE $results;
    close(OUTFILE);
    return ($rc,$results);
}


=head2 create_wrapper

 Title   : create_wrapper
 Usage   : $self->create_wrapper
 Function: Creates the wrapper file for the batchfile specified in the hash, saves it to the hash as '_wrapper'.
 Returns : nothing
 Args    : none


=cut

sub create_wrapper {
    my $self = shift;
    my $batchfile = $self->batchfile;
    unless (defined($batchfile)) {
        $self->throw("No batchfile specified, couldn't create wrapper.");
    }

    unless (-f $batchfile) {
        # check to see if maybe this batchfile is a template batchfile
        my $new_bf = $self->io->catfile($self->hyphy_lib_dir,"TemplateBatchFiles",$batchfile);
        $new_bf =~ s/\"//g;
        if (-f $new_bf) {
            $self->batchfile($new_bf);
        } else {
            $self->throw ("Specified batchfile $batchfile not found.");
            return;
        }
    }
    $self->SUPER::create_wrapper('"' . $self->batchfile . '"');
}

=head2 set_parameter

Title   :  set_parameter
Usage   :  $hyphy->set_parameter($param,$val);
Function:  Sets the named parameter $param to $val if it is a non-numeric parameter
           If $param is a number, sets the corresponding value of the ordered redirect array (starts from 1).
Returns :  boolean if set was successful
Args    :  $param => name of the parameter
           $value => value to set the parameter to

=cut


sub set_parameter {
    my ($self,$param,$value) = @_;
    if ($param =~ /\d+/) {
        $self->{'_params'}{'order'}[$param-1] = $value;
    } else {
        $self->{'_params'}{$param} = $value;
    }
    return 1;
}

=head2 batchfile

Title   :  batchfile
Usage   :  $hyphy->batchfile($bf_name);
Function:  Gets/sets the batchfile that is run by $hyphy.
Returns :  The batchfile path.
Args    :  $bf_name => path of new batchfile

=cut

sub batchfile {
    my ($self,$bf) = @_;
    if (defined $bf) {
        $self->set_parameter('bf', $bf);
    }

    if ($self->{'_params'}{'bf'}) {
        return $self->{'_params'}{'bf'};
    } else {
        $self->warn ("Batchfile was requested but no batchfile was found.");
    }
    return;
}

=head2 make_batchfile_with_contents

Title   :  make_batchfile_with_contents
Usage   :  $hyphy->make_batchfile_with_contents($bf_string);
Function:  Creates a temporary file with the specified string of contents for the batchfile.
Returns :  The batchfile path.
Args    :  $bf_string => contents for the batchfile

=cut

sub make_batchfile_with_contents {
    my ($self,$bf_string) = @_;
    my $temp_bf = $self->io->catfile($self->tempdir,"temp.bf");
    open (BF, ">", $temp_bf) or $self->throw("cannot open $temp_bf for writing");
    print BF "$bf_string\n";
    close BF;
    return $self->batchfile($temp_bf);
}


=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $BatchFile->set_default_parameters(0);
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the
            valid_values)
 Returns : none
 Args    : boolean: keep existing parameter values


=cut

sub set_default_parameters {
    my ($self,$keepold) = @_;
    unless (defined $keepold) {
        $keepold = 0;
    }
    my @validvals = $self->valid_values();
    for (my $i=0; $i< scalar (@validvals); $i++) {
        my $elem = @validvals[$i];
        keys %$elem; #reset hash iterator
        my ($param,$val) = each %$elem;
        # skip if we want to keep old values and it is already set
        if (ref($val)=~/ARRAY/i ) {
            $self->{'_orderedparams'}[$i] = {$param, $val->[0]};
        } else {
            $self->{'_orderedparams'}[$i] = {$param, $val};
        }
        #FIXME: for alignment and treefile, this should default to the ones in params.
    }
}

1;
