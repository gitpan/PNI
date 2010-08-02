use 5.8.8;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'PNI',
    VERSION_FROM => 'lib/PNI.pm',
    PREREQ_PM    => {
        Carp => 0,
        Test::More  => 0.94,
        Test::Pod   => 1.00,
        Time::HiRes => 0,
        File::Find  => 0,
        English     => 0,
        File::Spec  => 0
    },
    (
        $] >= 5.005
        ? (
            ABSTRACT_FROM => 'lib/PNI.pm',
            AUTHOR        => 'G. Casati <fibo@cpan.org>'
          )
        : ()
    ),
);
