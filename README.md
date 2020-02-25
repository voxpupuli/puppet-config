# Puppet Configuration module

[![Build Status](https://travis-ci.org/voxpupuli/puppet-config.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-config)

Manage configuration for Puppet agent, `puppet apply` (masterless), `puppet cert`, and other Puppet tools.

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Example Hiera config](#example-hiera-config)

## Overview

This module utilizes Hiera hierarchies to customize Puppet configuration for all components:
  * ```puppet apply```
  * ```puppet agent```
  * ```puppet cert```
  * ```puppet lookup```
  * ...etc

## Module Description

Configures Puppet agent, user tools, etc. Complements and requires
  [puppetlabs/puppet_agent](https://forge.puppet.com/puppetlabs/puppet_agent)

* Performs single-option configuration changes allowing local customizations to remain
* Strives to demonstrate Puppet best practices.

## Setup

### What puppet_config affects

* Edits configuration file
  * Defaults to `$confdir + /puppet.conf`
* Notifies puppet service of changes
  * Defaults to `puppet`

### Setup Requirements

Requires the `puppet_agent` module.

## Usage

Configuration values in Hiera (or supplied by an node terminus):

* Common
  * `puppet_config::main` = Hash of configuration parameters for the `[main]` section
  * `puppet_config::user` = Hash of configuration parameters for the `[user]` section
  * `puppet_config::agent` = Hash of configuration parameters for the `[agent]` section
  * `puppet_config::master` = Hash of configuration parameters for the `[master]` section

### Example Hiera Config

Hiera configuration:

```
  classes:
    - puppet_agent
    - puppet_config

  puppet_config::main:
    loglevel: 'warning'
```
