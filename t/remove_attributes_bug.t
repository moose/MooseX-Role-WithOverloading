use strict;
use warnings;

use Test::More tests => 4;
use Test::NoWarnings 1.04 ':early';

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

