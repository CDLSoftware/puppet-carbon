# == Class carbon::config
#
# This class is called from carbon
#
class carbon::config {
  File {
    mode   => '0644',
    notify => Service[$carbon::cache_service_name],
  }

  file {
    '/etc/carbon/aggregation-rules.conf':
      content => template('carbon/aggregation-rules.conf.erb');

    '/etc/carbon/storage-schemas.conf':
      content => template('carbon/storage-schemas.conf.erb');

    '/etc/carbon/storage-aggregation.conf':
      content => template('carbon/storage-aggregation.conf.erb');

    '/etc/carbon/relay-rules.conf':
      ensure  => file,
      content => template('carbon/relay-rules.conf.erb'),
      notify  => Service[$carbon::relay_service_name];
  }

  augeas { 'set relay destinations':
    context => '/files/etc/carbon/carbon.conf',
    changes => ["set relay/DESTINATIONS '${carbon::carbon_relay_destinations}'"],
    notify  => Service[$carbon::relay_service_name]
  }

}
