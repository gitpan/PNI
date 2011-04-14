use 5.008008008;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'PNI',
    VERSION_FROM => 'lib/PNI.pm',
    PREREQ_PM    => {
        File::Find        => 0,
        File::Spec        => 0,
        List::Util        => 0,
		Math::Complex     => 0,
        Module::Pluggable => 0,
        Scalar::Util      => 0,
        Time::HiRes       => 0,
        Test::More        => 0,
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
