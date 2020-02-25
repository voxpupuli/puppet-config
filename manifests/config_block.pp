# Type: puppet_config::config_block
# =================================
#
# @summary Installs and manages a Puppet configuration block
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
define puppet_config::config_block(
  Hash $values = {},
) {
  # Add the [agent] block configs
  $values.each |String $setting, String $value| {
    puppet_config::inisetting { "${title} ${setting}":
      section => $name,
      setting => $setting,
      value   => $value,
    }
  }
}
