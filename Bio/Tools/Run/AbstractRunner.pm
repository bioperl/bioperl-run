package Bio::Tools::Run::AbstractRunner;
use strict;

use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;
our @ISA=qw(Bio::Root::Root Bio::Root::IO Bio::Tools::Run::WrapperBase);

use Bio::Root::AccessorMaker ('$'=>[qw(input_file output_file)]);

sub new {
    my ($class, @args)=@_;
    my $self=$class->SUPER::new(@args);
    $self->_initialize(@args);
    return $self;
}

sub _initialize {
    my ($self, @args)=@_;
    my ($program_name, $program_dir)=$self->_rearrange(
        [qw(program_name program_dir)], @args);
    defined $program_name and $self->program_name($program_name);
    defined $program_dir and $self->program_dir($program_dir);
}

sub _run_program {
    my $self=shift;
    my $program = shift;
    $program ||= $self->program_path; # See WrapperBase
    my $cmd = "$program ". $self->final_param ;
    print STDERR "$cmd\n";

    my $ret = system($cmd);
    $ret==0 or $self->throw("CMD: $cmd\nNot working properly\n$?");
}

sub run {
    my $self=shift;
    $self->_find_files(shift);
    $self->_create_input_files;
    $self->run_file;
    $self->_parse_output_files;
    
}

no strict 'refs';
for my $method (qw(final_param _find_files _create_input_files _parse_output_files aaaa)){
    *{__PACKAGE__ . $method} = sub {shift->throw_not_implemented;};
}

1;

__END__

=pod

=head1 NAME

Bio::Tools::Run::AbstractRunner


=head1 SYNOPSIS


=head1 DESCRIPTION

=head2 Objective

The problems of bioperl-run wrapper before the time this module is made are:

=over 4

=item * There are a lot of duplicate code among bioperl-run modules

=item * 

It seems only to support object-in-object-out process, while sometimes people
just need file-in-file-out one, which has been actually implemented but not
exposed as a public method.

=item *

the different implementations, which should be similar and easy,
confuse the new developers who wants to make wrappers for their own programs 
but did not know how. 
So it is better to review bioperl-run and make the simple things as they should be.

=back

=head2 Temp file issues

    $runner->add_tmp_file($tmp_file);
    $runner->remove_tmp_files;

=head2 Unimplemented

Since it is an abstract module where there are methods to be implemented in
the concrete modules

=over 4

=item * final_param

=item * _find_files

=item * _create_input_files

=item * _parse_output_files

=back

=head1 AUTHOR

Juguang Xiao, juguang at tll.org.sg

=head1 COPYRIGHT

This module is a free software.
You may copy or redistribute it under the same terms as Perl itself.

=cut
