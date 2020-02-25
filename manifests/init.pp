# Class: puppet_config
# ====================
#
# Manages Puppet configuration
#
# Parameters
# ----------
#
# @param [Hash[String,Optional[String]]] config Hash of configuration parameters for the [main] block of puppet.conf
# * `main`
# Hash of key/value Puppet configuration settings for the [main] block of puppet.conf
#
# Examples
# --------
# @example Hiera configuration
#    classes:
#      - puppet_config
#
#    puppet_config::main:
#      loglevel: 'info'
#      logtarget: 'syslog'
#
# Authors
# -------
# @author Jo Rhett, Net Consonance
#   report issues at https://github.com/voxpupuli/puppet-config/issues
#
# Copyright
# ---------
# Copyright 2020, Vox Pupuli
# All Rights Reserved
#
class puppet_config(
  # Default values in data/defaults.yaml
  String $config_file  = "${facts['puppet_confdir']}/puppet.conf",
  String $service_name = 'puppet',
  Hash[String,Variant[String,Boolean,Integer,Undef]] $main   = {},
  Hash[String,Variant[String,Boolean,Integer,Undef]] $user   = {},
  Hash[String,Variant[String,Boolean,Integer,Undef]] $agent  = {},
  Hash[String,Variant[String,Boolean,Integer,Undef]] $master = {},
) {
  #include puppet_agent

  # Write each main configuration option to the puppet.conf file
  puppet_config::config_block { 'main':
    values => $main,
  }
  puppet_config::config_block { 'user':
    values => $user,
  }
  puppet_config::config_block { 'agent':
    values => $agent,
  }
  puppet_config::config_block { 'master':
    values => $master,
  }

  # Notify the named service for inifile changes
  if defined(Service[$service_name]) {
    Puppet_config::Inisetting<| |>  ~> Service[$service_name]
  }
}
