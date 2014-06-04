use strict;
use warnings;

BEGIN {
    eval { require ExtUtils::MakeMaker::Dist::Zilla::Develop };
    if ($@) {
        warn
            "You need to install ExtUtils::MakeMaker::Dist::Zilla::Develop to run this Makefile.PL\n";
        exit 1;
    }

    ExtUtils::MakeMaker::Dist::Zilla::Develop->import();
}

WriteMakefile(
    NAME           => 'MooseX::Role::WithOverloading',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
);
