use 5.010001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'PNI',
    VERSION_FROM      => 'lib/PNI.pm', # finds $VERSION
    PREREQ_PM         => { 
        Test::More  => 0, 
        Time::HiRes => 0,
        File::Find  => 0,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/PNI.pm', # retrieve abstract from module
       AUTHOR         => 'G. Casati <fibo@cpan.org>') : ()),
);
