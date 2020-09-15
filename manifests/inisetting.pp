# Type: puppet_config::inisetting
# ===============================
#
# Installs and manages Puppet configuration setting
#
# Parameters
# --------
# @param [Enum['main','user','agent','master']] section Section of the configuration file
# * `section`
# Section of the configuration file. One of 'main','user','agent','master'
#
# @param [String] setting Name of the configuration setting
# * `setting`
# Name of the configuration setting
#
# @param [Variant[String,Integer,Boolean,Undef]] value Value for the setting
# * `value`
# Default value: undef
#
# Examples
# --------
# @example Hiera configuration
#    classes:
#      - puppet
#
#    puppet::version: 'latest'
#    puppet::config:
#      loglevel: 'info'
#      logtarget: 'syslog'
#
# Authors
# -------
# @author Jo Rhett, Net Consonance 
#   report issues to https://github.com/voxpupuli/puppet-config/issues
#
# Copyright
# ---------
# Copyright 2017, Vox Pupuli
# All Rights Reserved
#
define puppet_config::inisetting (
  String $setting,
  Enum['main','user','agent','master'] $section = 'main',
  Variant[String,Boolean,Integer,Undef] $value  = undef,
) {
  # Remove values not defined or empty
  $is_present = $value ? {
    undef   => 'absent',
    ''      => 'absent',
    default => 'present',
  }

  # Write the agent configuration option to the puppet.conf file
  ini_setting { $title:
    ensure       => $is_present,
    path         => "${facts['puppet_confdir']}/puppet.conf",
    section      => $section,
    setting      => $setting,
    value        => $value,
    indent_width => 2,
  }
}
