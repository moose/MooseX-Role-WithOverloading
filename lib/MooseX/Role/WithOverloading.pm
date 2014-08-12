package MooseX::Role::WithOverloading;
# ABSTRACT: Roles which support overloading
# KEYWORDS: moose extension role operator overload overloading

use XSLoader;
use Moose::Role ();
use Moose::Exporter;
use aliased 'MooseX::Role::WithOverloading::Meta::Role', 'MetaRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToClass';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToRole';
use aliased 'MooseX::Role::WithOverloading::Meta::Role::Application::ToInstance';

use namespace::clean;

XSLoader::load(
    __PACKAGE__,
    $MooseX::Role::WithOverloading::{VERSION}
    ? ${ $MooseX::Role::WithOverloading::{VERSION} }
    : ()
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

1;

=for stopwords metaclasses

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

=cut
