# == Class carbon::params
#
# This class is meant to be called from carbon
# It sets variables according to platform
#
class carbon::params {
  case $::osfamily {
    'RedHat', 'Amazon' : {
      $package_name              = 'python-carbon'
      $cache_service_name        = 'carbon-cache'
      $aggregator_service_name   = 'carbon-aggregator'
      $relay_service_name        = 'carbon-relay'
      $cache_service_ensure      = running
      $aggregator_service_ensure = running
      $relay_service_ensure      = running
      $aggregator_rules          = {
        'carbon-class-mem' => 'carbon.all.<class>.memUsage (60) = sum carbon.<class>.*.memUsage',
        'carbon-all-mem'   => 'carbon.all.memUsage (60) = sum carbon.*.*.memUsage',
      }
      $storage_aggregation_rules = {
        '00_min'         => {
          pattern => '\.min$',
          factor  => '0.1',
          method  => 'min'
        }
        ,
        '01_max'         => {
          pattern => '\.max$',
          factor  => '0.1',
          method  => 'max'
        }
        ,
        '02_sum'         => {
          pattern => '\.count$',
          factor  => '0.1',
          method  => 'sum'
        }
        ,
        '99_default_avg' => {
          pattern => '.*',
          factor  => '0.5',
          method  => 'average'
        }
      }
      $storage_schemas           = [
        {
          name       => 'carbon',
          pattern    => '^carbon\.',
          retentions => '1m:90d'
        }
        ,
        {
          name       => 'default',
          pattern    => '.*',
          retentions => '1s:30m,1m:1d,5m:2y'
        }
        ]

      $relay_rules               = {
        'default' => {
          destinations => '127.0.0.1:2004:a, 127.0.0.1:2104:b',
        }
        ,
      }
      $carbon_relay_destinations = '127.0.0.1:2004:a, 127.0.0.1:2104:b'
    }
    default            : {
      fail("${::operatingsystem} not supported")
    }
  }
}
