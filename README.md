# NAME

MooseX::Role::WithOverloading - Roles which support overloading

# SYNOPSIS

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

# DESCRIPTION

MooseX::Role::WithOverloading allows you to write a [Moose::Role](http://search.cpan.org/perldoc?Moose::Role) which
defines overloaded operators and allows those operator overloadings to be
composed into the classes/roles/instances it's compiled to, while plain
[Moose::Role](http://search.cpan.org/perldoc?Moose::Role)s would lose the overloading.

# AUTHORS

- Florian Ragwitz <rafl@debian.org>
- Tomas Doran <bobtfish@bobtfish.net>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
