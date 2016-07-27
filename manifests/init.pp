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
  $package_name              = $carbon::params::package_name,
  $service_name              = $carbon::params::cache_service_name,
  $aggregator_service_name   = $carbon::params::aggregator_service_name,
  $relay_service_name        = $carbon::params::relay_service_name,
  $cache_service_ensure      = $carbon::params::cache_service_ensure,
  $aggregator_service_ensure = $carbon::params::aggregator_service_ensure,
  $relay_service_ensure      = $carbon::params::relay_service_ensure,
  $aggregator_rules          = $carbon::params::aggregator_rules,
  $storage_aggregation_rules = $carbon::params::storage_aggregation_rules,
  $storage_schemas           = $carbon::params::storage_schemas,
  $relay_rules               = $carbon::params::relay_rules,
  $carbon_relay_destinations = $carbon::params::carbon_relay_destinations,
  $carbon_relay_max_queue_size = $carbon::params::carbon_relay_max_queue_size,) inherits carbon::params {
  # validate parameters here

  class { 'carbon::install':
  } ->
  class { 'carbon::config': } ~>
  class { 'carbon::service': } ->
  Class['carbon']
}
