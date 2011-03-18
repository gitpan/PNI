use strict;
use Test::More;
use PNI::Error;

ok PNI::Error::verbose_on, 'verbose_on';

# test verbose_off now so next tests will be silent
ok PNI::Error::verbose_off, 'verbose_off';

# all PNI errors should return undef
is PNI::Error::generic,                   undef, 'generic';
is PNI::Error::invalid_argument_type,     undef, 'invalid_argument_type';
is PNI::Error::missing_required_argument, undef, 'missing_required_argument';

done_testing;
