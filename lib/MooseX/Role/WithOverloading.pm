package MooseX::Role::WithOverloading;
# ABSTRACT: (DEPRECATED) Roles which support overloading
# KEYWORDS: moose extension role operator overload overloading deprecated

our $VERSION = '0.18';

use Moose::Role ();
use Moose::Exporter;
use aliased 'MooseX::Role::WithOverloading::Meta::Role', 'MetaRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToClass';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance';

use namespace::clean 0.19;

# this functionality is built-in, starting with Moose 2.1300
my $has_core_support = eval { Moose->VERSION('2.1300'); 1 };

if ($has_core_support)
{
    Moose::Exporter->setup_import_methods(also => 'Moose::Role');
}
else
{
    require XSLoader;
    XSLoader::load(
        __PACKAGE__,
        $VERSION,
    );

    Moose::Exporter->setup_import_methods(
        also           => 'Moose::Role',
        role_metaroles => {
            role                    => [MetaRole],
            application_to_class    => [ToClass],
            application_to_role     => [ToRole],
            application_to_instance => [ToInstance],
        },
    );
}

1;
__END__

=pod

=for stopwords metaclasses

=head1 DEPRECATION NOTICE

This module is marked as deprecated, as starting with L<Moose> version 2.1300,
the functionality provided here is now built-in to Moose. You only need to use
this module if you are using an older L<Moose> (but please upgrade!).

=head1 SYNOPSIS

    package MyRole;
    use MooseX::Role::WithOverloading;

    use overload
        q{""}    => 'as_string',
        fallback => 1;

    has message => (
        is       => 'rw',
        isa      => 'Str',
    );

    sub as_string { shift->message }

    package MyClass;
    use Moose;
    use namespace::autoclean;

    with 'MyRole';

    package main;

    my $i = MyClass->new( message => 'foobar' );
    print $i; # Prints 'foobar'

=head1 DESCRIPTION

MooseX::Role::WithOverloading allows you to write a L<Moose::Role> which
defines overloaded operators and allows those overload methods to be
composed into the classes/roles/instances it's compiled to, where plain
L<Moose::Role>s would lose the overloading.

Starting with L<Moose> version 2.1300, this module is no longer necessary, as
the functionality is available already. In that case,
C<use MooseX::Role::WithOverloading> behaves identically to C<use Moose::Role>.

=cut
