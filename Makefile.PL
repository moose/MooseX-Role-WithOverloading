use strict;
use warnings;
use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;

WriteMakefile(
    NAME           => 'MooseX::Role::WithOverloading',
    VERSION_FROM   => 'lib/MooseX/Role/WithOverloading.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
);
