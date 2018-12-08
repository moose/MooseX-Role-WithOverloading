use strict;
use warnings;

use Test::More 0.96;
use Test::Deep;
use Test::Warnings ':all';
use overload ();

use lib 't/lib';

BEGIN {
    cmp_deeply(
        [ warnings { require MooseX::Role::WithOverloading } ],
        [ re(qr/As of Moose 2.1300, MooseX::Role::WithOverloading is not needed/) ],
        'got deprecation warning',
    );
}

BEGIN { use_ok('OtherClass') }

ok(OtherClass->meta->does_role('Role'));
ok(OtherClass->meta->does_role('OtherRole'));

ok(overload::Overloaded('Role'));
ok(overload::Overloaded('OtherRole'));
ok(overload::Overloaded('OtherClass'));
ok(overload::Method('Role', q{""}));
ok(overload::Method('OtherRole', q{""}));
ok(overload::Method('OtherClass', q{""}));

my $foo = OtherClass->new({ message => 'foo' });
isa_ok($foo, 'OtherClass');
is($foo->message, 'foo');

my $str = "${foo}";
is($str, 'foo');

# These tests failed on 5.18+ without some fixes to the MXRWO internals
{
    package MyRole1;
    use MooseX::Role::WithOverloading;
    use overload q{""} => '_stringify';
    sub _stringify { __PACKAGE__ };
}

{
    package MyRole2;
    use Moose::Role;
    with 'MyRole1';
}

{
    package Class1;
    use Moose;
    with 'MyRole2';
}

is(
    Class1->new . q{},
    'MyRole1',
    'stringification overloading is passed through all roles'
);

had_no_warnings() if $ENV{AUTHOR_TESTING};
done_testing();
