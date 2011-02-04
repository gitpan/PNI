use 5.8.8;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'PNI',
    VERSION_FROM => 'lib/PNI.pm',
    PREREQ_PM    => {
        File::Find  => 0,
        File::Spec  => 0,
        Time::HiRes => 0,
        Test::More  => 0.94,
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
