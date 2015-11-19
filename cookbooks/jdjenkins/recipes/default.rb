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

group 'docker' do
  action :create
  gid 999
  members ['ec2-user']
end

package 'docker-io' do
  action :install
end

service 'docker' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

