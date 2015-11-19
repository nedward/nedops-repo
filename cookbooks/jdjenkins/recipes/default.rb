#
# Cookbook Name:: jdjenkins
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

user 'jenkins' do
  action :delete
  # comment 'Jenkins Service User'
  # uid 1000
  # gid 'jenkins'
  # home '/home/jenkins'
  # shell '/bin/zsh'
  # password 'Agilent123'
  # supports :manage_home => true
end


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
  members ['jenkins']
end

package 'docker-io' do
  action :install
end

service 'docker' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

