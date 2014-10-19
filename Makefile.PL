use strict;
use warnings;
use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;
WriteMakefile(
    NAME           => 'MooseX::Role::WithOverloading',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
);
