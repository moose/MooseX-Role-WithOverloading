use strict;
use warnings;

use Test::More 0.96;
use Test::Deep;
use Test::Warnings ':all';
use overload ();

use lib 't/lib';

cmp_deeply(
    [ warnings { require Role } ],
    [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
    'got deprecation warning',
);

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

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing();
