# wharton-jboss-eap6

## Description

Installs/configures Red Hat JBoss Enterprise Application Platform 6

## Requirements

### Platforms

* RedHat 6.3 (Santiago)

## Attributes

* `node["jboss-eap6"]["mgmt-users"]` - array of hashes with username and
  password for users in ManagementRealm, defaults to []

## Recipes

* `recipe[wharton-jboss-eap6]` will install and enable JBoss EAP 6

## Usage

Add `recipe[wharton-jboss-eap6]` in your run list.
