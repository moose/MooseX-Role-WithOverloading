use strict;
use warnings;

use Test::More 0.96;
use Test::Warnings;
use overload ();

use lib 't/lib';

use Role;

{
    package MyClass;
    use Moose;
    use namespace::autoclean;
}

my $foo = MyClass->new;
Role->meta->apply($foo);
isa_ok($foo, 'MyClass');

ok(overload::Overloaded('Role'));
ok(overload::Overloaded(ref $foo));
ok(overload::Method('Role', q{""}));
ok(overload::Method(ref $foo, q{""}));

$foo->message('foo');

my $str = "${foo}";
is($str, 'foo');

done_testing();
