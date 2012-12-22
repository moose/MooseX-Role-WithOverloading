use strict;
use warnings;

use Test::More tests => 13;
use Test::NoWarnings 1.04 ':early';
use overload ();

use lib 't/lib';

BEGIN { use_ok('CombiningClass') }

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

