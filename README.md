# chef-jbossas7 [![Build Status](https://secure.travis-ci.org/wharton/chef-jbossas7.png?branch=master)](http://travis-ci.org/wharton/chef-jbossas7)

## Description

Installs/configures JBoss AS 7.  Automatically can create standalone 
instances or a secure and complete JBoss domain setup.

## Requirements

### Platforms

* Ubuntu 12.04 (precise)

## Attributes
* `node["jbossas7"]["install_dir"]` - base directory to unpack JBoss to
* `node["jbossas7"]["version"]` - version to download and install, defaults to 
  "7.1.1.Final".  
* `node["jbossas7"]["download_url"]` - URL to download from, defaults to 
  "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"
* TODO: default["jbossas7"]["user"]                      = "jboss"
* TODO: default["jbossas7"]["group"]                     = "jboss"
* `node["jbossas7"]["hostname"]` - alpha-numeric ONLY JBoss AS
  server name used in domain mode (must match with mgmt-user entry), defaults to
  `node["hostname"].gsub(/[-_]/,"")`
* `node["jbossas7"]["mgmt-users"]` - array of hashes with username,
  password hash, and secret for users in JBoss AS ManagementRealm, defaults to
  []
* `node["jbossas7"]["mode"]` - JBoss AS server mode - "domain" or
  "standalone", defaults to "standalone"

* `node["jbossas7"]["bind"]["management"]` - JBoss AS server
  binding IP for management interface, defaults to "127.0.0.1"
* `node["jbossas7"]["bind"]["public"]` - JBoss AS server binding IP
  for public interface, defaults to "127.0.0.1"
* `node["jbossas7"]["bind"]["unsecure"]` - JBoss AS server binding
  IP for unsecure interface, defaults to "127.0.0.1"

* `node["jbossas7"]["domain"]["host_type"]` - set host as "master"
  or "slave" in domain, defaults to "master"
* `node["jbossas7"]["domain"]["master"]["address"]` - remote
  domain master address, defaults to ""
* `node["jbossas7"]["domain"]["master"]["port"]` - remote
  domain master port, defaults to 9999
* `node["jbossas7"]["domain"]["name"]` - for multiple clusters,
  defaults to nil

# Recipes

* `recipe[jbossas7]` will install and configure JBoss AS 7
* `recipe[jbossas7::configuration]` attribute-driven configuration

## Usage

### Public Standalone Instance

* If you don't already have a ManagementRealm username, password hash, and
  secret, generate one via `$JBOSS_HOME/bin/add-user.sh`
* Create attributes, example below
* Add `recipe[jbossas7]`/`recipe[jbossas7::eap6]` to your node's run list

Example attributes with localhost management interface:

    "jbossas7" => {
      "bind" => {
        "public" => "0.0.0.0"
      },
      "mgmt-users" => {
        "admin" => {
          "password" => "add-user.sh-hash-of-password",
          "secret" => "add-user.sh-secret-of-password"
        }
      }
    }

### Domain Instances

* If you don't already have a ManagementRealm username, password hash, and
  secret, generate one via `$JBOSS_HOME/bin/add-user.sh`
* Create attributes for master instance, example below
* Add `recipe[jbossas7]`/`recipe[jbossas7::eap6]` to your master's run list and
  run it
* Create attributes for slave instances, example below
* Add `recipe[jbossas7]`/`recipe[jbossas7::eap6]` to your slaves' run list and
  run it
  * _note_: startup will fail the first time; its okay! the master needs to
    reconverge with the new slave authentication data before the slave will
    start

### Domain Master Instance

Example attributes with remotely accessible management interface:

    "jbossas7" => {
      "bind" => {
        "management" => "0.0.0.0"
      },
      "mgmt-users" => {
        "admin" => {
          "password" => "add-user.sh-hash-of-password",
          "secret" => "add-user.sh-secret-of-password"
        }
      },
      "mode" => "domain"
    }

### Domain Slave Instance

_PLEASE NOTE_: you can omit
`node["jbossas7"]["domain"]["master"]["address"]` - it will
auto-discover if possible

Example attributes with remotely accessible management (required) and public
interfaces:

    "jbossas7" => {
      "bind" => {
        "management" => "0.0.0.0",
        "public" => "0.0.0.0"
      },
      "domain" => {
        "host_type" => "slave",
        "master" => { "address" => "X.X.X.X" }
      }
      "mgmt-users" => {
        "admin" => {
          "password" => "add-user.sh-hash-of-password",
          "secret" => "add-user.sh-secret-of-password"
        }
      },
      "mode" => "domain"
    }

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)
Author:: Joshua Buysse (<buysse@umn.edu>)

Copyright:: 2012, 2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
