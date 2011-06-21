use strict;
use Test::More;

BEGIN {
    use_ok($_)
      or BAIL_OUT(" $_ module is not installed")
      for qw(
      Cwd
      File::Find
      List::Util
      Math::Complex
      Module::Pluggable
      Scalar::Util
      Test::More
      Time::HiRes
    );
}

done_testing;

