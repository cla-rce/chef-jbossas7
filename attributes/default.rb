#
# Cookbook Name:: jbossas7
# Recipe:: default
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["jbossas7"]["version"]                   = "7.1.1.Final"
default["jbossas7"]["ark_package_name"]          = "jbossas7"
# this is the default; changing doesn't seem functional with ark cookbook
# may be fixed in a newer version of the ark cookbook
default["jbossas7"]["ark_base_dir"]              = "/usr/local"

default['jbossas7']['install_dir']               = "#{node["jbossas7"]["ark_base_dir"]}/#{node["jbossas7"]["ark_package_name"]}"
default["jbossas7"]["download_url"]              = "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"
default["jbossas7"]["download_checksum"]         = "88fd3fdac4f7951cee3396eff3d70e8166c3319de82d77374a24e3b422e0b2ad"

default["jbossas7"]["user"]                      = "jboss"
default["jbossas7"]["group"]                     = "jboss"

default["jbossas7"]["home"]                      = "/var/lib/jbossas7"
default["jbossas7"]["hostname"]                  = node["hostname"].gsub(/[-_]/,"")
default["jbossas7"]["JBOSS_MODULES_SYSTEM_PKGS"] = []
default["jbossas7"]["LD_LIBRARY_PATH"]           = nil
default["jbossas7"]["mgmt-users"]                = {}
default["jbossas7"]["mode"]                      = "standalone"

case platform_family
when "debian"
  default["jbossas7"]["default_dir"] = "/etc/default"
when "redhat"
  default["jbossas7"]["default_dir"] = "/etc/sysconfig"
else
  default["jbossas7"]["default_dir"] = "/etc/default"
end

default["jbossas7"]["bind"]["public"]     = "127.0.0.1"
default["jbossas7"]["bind"]["management"] = "127.0.0.1"
default["jbossas7"]["bind"]["unsecure"]   = "127.0.0.1"

default["jbossas7"]["domain"]["host_type"]         = "master"
default["jbossas7"]["domain"]["JAVA_OPTS"]         = %w{
  -Xms1303m
  -Xmx1303m
  -XX:MaxPermSize=256m
  -Djava.net.preferIPv4Stack=true
  -Dorg.jboss.resolver.warning=true
  -Dsun.rmi.dgc.client.gcInterval=3600000
  -Dsun.rmi.dgc.server.gcInterval=3600000
}
default["jbossas7"]["domain"]["master"]["address"] = nil
default["jbossas7"]["domain"]["master"]["port"]    = 9999
default["jbossas7"]["domain"]["name"]              = nil

default["jbossas7"]["standalone"]["JAVA_OPTS"]  = %w{
  -Xms1303m
  -Xmx1303m
  -XX:MaxPermSize=256m
  -Djava.net.preferIPv4Stack=true
  -Dorg.jboss.resolver.warning=true
  -Dsun.rmi.dgc.client.gcInterval=3600000
  -Dsun.rmi.dgc.server.gcInterval=3600000
}
