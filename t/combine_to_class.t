use strict;
use warnings;

use Test::More 0.96;
use Test::Warnings ':all';
use Test::Deep;
use overload ();

use lib 't/lib';

cmp_deeply(
    [ warnings { use_ok('CombiningClass') } ],
    [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
    'got deprecation warning',
);

ok(CombiningClass->meta->does_role('UnrelatedRole'));
ok(CombiningClass->meta->does_role('Role'));

ok(!overload::Overloaded('UnrelatedRole'));
ok(overload::Overloaded('Role'));
ok(overload::Overloaded('CombiningClass'));
ok(!overload::Method('UnrelatedRole', q{""}));
ok(overload::Method('Role', q{""}));
ok(overload::Method('CombiningClass', q{""}));

my $foo = CombiningClass->new({ message => 'foo' });
isa_ok($foo, 'CombiningClass');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing();
