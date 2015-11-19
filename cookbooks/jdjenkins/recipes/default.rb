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

jenkins_plugin 'git' do
	notifies :restart, 'service[jenkins]'
end

chef_dk 'my_chef_dk' do
	global_shell_init true
	action :install
end

group 'docker' do
  action :create
  gid 999
  members ['jenkins']
end

package 'docker-io' do
  action :install
end

gem_package "kitchen-docker" do
  gem_binary "/opt/chefdk/embedded/bin/gem"
  options "--no-user-install"
  notifies :restart, "service[docker]"
end

service 'docker' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

service 'jenkins' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable, :restart]
end
