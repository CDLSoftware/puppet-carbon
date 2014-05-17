# == Class carbon::params
#
# This class is meant to be called from carbon
# It sets variables according to platform
#
class carbon::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $package_name = 'python-carbon'
      $cache_service_name = 'carbon-cache'
      $aggregator_service_name = 'carbon-aggregator'
      $aggregator_rules = {
        'carbon-class-mem' => 'carbon.all.<class>.memUsage (60) = sum carbon.<class>.*.memUsage',
        'carbon-all-mem'   => 'carbon.all.memUsage (60) = sum carbon.*.*.memUsage',
      }
      $storage_aggregation_rules = {
        '00_min'         => { pattern => '\.min$',   factor => '0.1', method => 'min' },
        '01_max'         => { pattern => '\.max$',   factor => '0.1', method => 'max' },
        '02_sum'         => { pattern => '\.count$', factor => '0.1', method => 'sum' },
        '99_default_avg' => { pattern => '.*',       factor => '0.5', method => 'average'}
      }
      $storage_schemas = [
        {
          name       => 'carbon',
          pattern    => '^carbon\.',
          retentions => '1m:90d'
        },
        {
          name       => 'default',
          pattern    => '.*',
          retentions => '1s:30m,1m:1d,5m:2y'
        }
      ]
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
