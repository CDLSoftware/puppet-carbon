####Table of Contents

1. [Overview](#overview)
    * [Using the module](#using-the-module)
1. [Usage](#usage)
    * [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

##Overview

A module for CentOS/RHEL 6 that configures and runs the Carbon part of the Graphite stack from EPEL. This is designed to be used with [my module for graphite-api](https://forge.puppetlabs.com/stevenmerrill/graphiteapi).

Several of the templates and parameters were copied from [Daniel Werdermann's Graphite module](https://forge.puppetlabs.com/dwerder/graphite).

### Using the module

To install with the default parameters, use the following configuration.

```
include carbon
```

There are also several [parameters you can set](#parameters) to control carbon-cache and carbon-aggregator's operation.

##Usage

###Parameters

#####`package_name`

This defaults to `python-carbon`, which will also install `python-whisper` and the necessary python dependencies from EPEL.

#####`cache_service_name`

This defaults to 'carbon-cache'.

#####`aggregator_service_name`

This defaults to 'carbon-aggregator'.

#####`aggregator_rules`

This is a hashmap of all the carbon aggregation rules.

The default is
```
{
  'carbon-class-mem'  => 'carbon.all.<class>.memUsage (60) = sum carbon.<class>.*.memUsage',
  'carbon-all-mem'    => 'carbon.all.memUsage (60) = sum carbon.*.*.memUsage',
}
```

#####`storage_schemas`

The storage schemas, which describes how long matching graphs are to be stored in detail.

The default is
```
[
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
```
The storage schemas, which describes how long matching graphs are to be stored in detail.

#####`storage_aggregation_rules`

This is a hashmap of the storage aggregation rules.

The default is
```
{
  '00_min'         => { pattern => '\.min$',   factor => '0.1', method => 'min' },
  '01_max'         => { pattern => '\.max$',   factor => '0.1', method => 'max' },
  '02_sum'         => { pattern => '\.count$', factor => '0.1', method => 'sum' },
  '99_default_avg' => { pattern => '.*',       factor => '0.5', method => 'average'}
}
```


##Limitations

This module will only work with RHEL or CentOS 6 at the moment, and will likely always be limited to RHELish systems. If you are not interested in installing carbon from packages, check out [Daniel Werdermann's excellent Graphite module](https://forge.puppetlabs.com/dwerder/graphite).

It requires the EPEL repository, and expects that [Michael Stahnke's EPEL class](https://forge.puppetlabs.com/stahnma/epel) (or any class named "epel") will provide those.

##Development

I will look at any pull requests. If you have a machine with Vagrant 1.6+ and Docker, you can quickly spin up a CentOS container to test using the vagrant-test directory here. [https://github.com/smerrill/puppet-carbon-graphiteapi-tests](https://github.com/smerrill/puppet-carbon-graphiteapi-tests) will also let you test this module along with my graphite-api module.
