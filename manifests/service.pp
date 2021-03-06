# == Class carbon::service
#
# This class is meant to be called from carbon
# It ensure the service is running
#
class carbon::service {
  service { $carbon::cache_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  service { $carbon::aggregator_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
