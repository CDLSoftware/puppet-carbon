# == Class carbon::install
#
class carbon::install {
  package { $carbon::package_name:
    ensure  => present,
    require => Class['epel'],
  }
}
