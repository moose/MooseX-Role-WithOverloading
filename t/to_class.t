use strict;
use warnings;

use Test::More 0.96;
use Test::Deep;
use Test::Warnings ':all';
use overload ();

use lib 't/lib';

cmp_deeply(
    [ warnings { use_ok('SomeClass') } ],
    [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
    'got deprecation warning',
);

ok(SomeClass->meta->does_role('Role'));

ok(overload::Overloaded('Role'));
ok(overload::Overloaded('SomeClass'));
ok(overload::Method('Role', q{""}));
ok(overload::Method('SomeClass', q{""}));

my $foo = SomeClass->new({ message => 'foo' });
isa_ok($foo, 'SomeClass');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing();
