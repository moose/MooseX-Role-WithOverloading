use strict;
use warnings;

use Test::More 0.88;
use Test::Deep;
use Test::Warnings ':all';

plan skip_all => 'Moose 2.1300 required for these tests'
    unless eval { +require Moose; Moose->VERSION('2.1300'); };   # XXX Test::Requires? watch for prereq injection.

use lib 't/lib';

cmp_deeply(
    [ warnings { use_ok('SomeClass') } ],
    [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
    'got deprecation warning',
);

ok(SomeClass->meta->does_role('Role'), 'class does the role');
ok(overload::Method('Role', q{""}), 'the overload is on the role');
ok(overload::Method('SomeClass', q{""}), 'the overload is on the class');

ok(
    !Role->meta->meta->isa('Moose::Meta::Class'),
    "the role's metaclass has not been upgraded from a Class::MOP::Class::Immutable::Class::MOP::Class to a full Moose metaclass",
);

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing;
