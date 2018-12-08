use strict;
use warnings;

use Test::More 0.96;
use Test::Deep;
use Test::Warnings ':all';
use overload ();

use lib 't/lib';

cmp_deeply(
    [ warnings { use_ok('ClassWithCombiningRole') } ],
    [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
    'got deprecation warning',
);

ok(ClassWithCombiningRole->meta->does_role('Role'));
ok(ClassWithCombiningRole->meta->does_role('UnrelatedRole'));
ok(ClassWithCombiningRole->meta->does_role('CombiningRole'));

ok(!overload::Overloaded('UnrelatedRole'));
ok(overload::Overloaded('Role'));
ok(overload::Overloaded('CombiningRole'));
ok(overload::Overloaded('ClassWithCombiningRole'));
ok(!overload::Method('UnrelatedRole', q{""}));
ok(overload::Method('Role', q{""}));
ok(overload::Method('CombiningRole', q{""}));
ok(overload::Method('ClassWithCombiningRole', q{""}));

my $foo = ClassWithCombiningRole->new({ message => 'foo' });
isa_ok($foo, 'ClassWithCombiningRole');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing();
