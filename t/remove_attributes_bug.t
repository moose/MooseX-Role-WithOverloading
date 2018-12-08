use strict;
use warnings;

use Test::More 0.96;
use Test::Deep;
use Test::Warnings ':all';

BEGIN {
    cmp_deeply(
        [ warnings { require MooseX::Role::WithOverloading } ],
        [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
        'got deprecation warning',
    );
}

{
    package OverloadingRole;
    use MooseX::Role::WithOverloading;

    use overload
        q{""}    => 'stringify',
        fallback => 1;

    sub stringify { 'moo' }
}

{
    package MyRole;
    use Moose::Role;

    has hitid => ( is => 'ro' );

    # Note ordering here. If metaclass reinitialization nukes attributes, we are screwed..
    with 'OverloadingRole';
}

{
    package Class;
    use Moose;

    with 'MyRole';
}

my $i = Class->new( hitid => 21 );

is("$i", 'moo', 'overloading works');
can_ok($i, 'hitid' );
is($i->hitid, 21, 'Attribute works');

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing();
