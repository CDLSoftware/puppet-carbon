# == Class carbon::params
#
# This class is meant to be called from carbon
# It sets variables according to platform
#
class carbon::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'carbon'
      $service_name = 'carbon'
    }
    'RedHat', 'Amazon': {
      $package_name = 'carbon'
      $service_name = 'carbon'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
