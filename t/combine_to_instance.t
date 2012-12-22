use strict;
use warnings;

use Test::More tests => 7;
use Test::NoWarnings 1.04 ':early';
use overload ();

use lib 't/lib';

use Role;
use UnrelatedRole;

{
    package MyClass;
    use Moose;
    use namespace::autoclean;
}

my $foo = MyClass->new;

Moose::Meta::Role->combine(
    [ 'Role'          => undef ],
    [ 'UnrelatedRole' => undef ],
)->apply($foo);

isa_ok($foo, 'MyClass');

ok(overload::Overloaded('Role'));
ok(overload::Overloaded(ref $foo));
ok(overload::Method('Role', q{""}));
ok(overload::Method(ref $foo, q{""}));

$foo->message('foo');

my $str = "${foo}";
is($str, 'foo');

