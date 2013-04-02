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

# To-Do!

# create the users for the installation

group node["jbossas7"]["group"] do 
  action :create
  system true
end

user node["jbossas7"]["user"] do 
  action [:create, :manage]
  supports :manage_home => true
  system true
  comment "JBoss AS7 application user"
  shell "/bin/bash"
  home node["jbossas7"]["home"]
  gid node["jbossas7"]["group"]
end

# unpack the installation
ark node["jbossas7"]["ark_package_name"] do 
  url node["jbossas7"]["download_url"]
  # path seems non-functional, will install in /usr/local
  #path node["jbossas7"]["ark_base_dir"]
  version node["jbossas7"]["version"]
  checksum node["jbossas7"]["download_checksum"]
  owner node["jbossas7"]["user"]
  group node["jbossas7"]["group"]
end

# set up an initscript for it?  
template "/etc/init.d/jbossas7" do 
  source "jbossas7.init.debian.erb"
  variables :name => "jbossas7",  
    :user => node["jbossas7"]["user"]
  mode "0755"
  owner "root"
  group "root"
  notifies :enable, "service[jbossas7]"
end

service "jbossas7" do 
  action :nothing
  supports :restart => true, :start => true, :stop => true, :reload => true
end
  
include_recipe "jbossas7::configuration"
