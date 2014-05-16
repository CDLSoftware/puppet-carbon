# == Class: carbon
#
# Full description of class carbon here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class carbon (
  $package_name = $carbon::params::package_name,
  $service_name = $carbon::params::service_name,
) inherits carbon::params {

  # validate parameters here

  class { 'carbon::install': } ->
  class { 'carbon::config': } ~>
  class { 'carbon::service': } ->
  Class['carbon']
}
