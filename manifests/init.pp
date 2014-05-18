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
  $service_name = $carbon::params::cache_service_name,
  $aggregator_service_name = $carbon::params::aggregator_service_name,
  $aggregator_rules = $carbon::params::aggregator_rules,
  $storage_aggregation_rules = $carbon::params::storage_aggregation_rules,
  $storage_schemas = $carbon::params::storage_schemas,
) inherits carbon::params {

  # validate parameters here

  class { 'carbon::install': } ->
  class { 'carbon::config': } ~>
  class { 'carbon::service': } ->
  Class['carbon']
}
