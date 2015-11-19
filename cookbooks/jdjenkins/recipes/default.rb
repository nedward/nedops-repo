#
# Cookbook Name:: jdjenkins
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'jenkins::master'
include_recipe 'chef-dk'

package 'git' do
  action :install
end

jenkins_plugin 'git'

chef_dk 'my_chef_dk'

user 'jenkins' do
  action :create
  comment 'Jenkins Service User'
  uid 1000
  gid ['users','docker']
  home '/home/jenkins'
  shell '/bin/zsh'
  password 'Agilent123'
  supports :manage_home => true
end


group 'docker' do
  action :create
  gid 999
  members ['jenkins']
end

package 'docker-io' do
  action :install
end

service 'docker' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

