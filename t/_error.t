use strict;
use Test::More;
use PNI::Error;

ok PNI::Error::verbose_on, 'verbose_on';

# test verbose_off now so next tests will be silent
ok PNI::Error::verbose_off, 'verbose_off';

# all PNI errors should return undef
#is PNI::Error::*, undef, '*';
is PNI::Error::generic,                       undef;
is PNI::Error::attribute_does_not_exists,     undef;
is PNI::Error::invalid_argument_type,         undef;
is PNI::Error::missing_required_argument,     undef;
is PNI::Error::unable_to_create_item,         undef;
is PNI::Error::unable_to_init_node,           undef;
is PNI::Error::unable_to_load_node,           undef;
is PNI::Error::unable_to_run_task,            undef;
is PNI::Error::unimplemented_abstract_method, undef;

done_testing;
__END__

