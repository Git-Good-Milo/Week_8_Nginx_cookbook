#
# Cookbook:: node03
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.


# apt_update and include_recipe 'apt' are the same
apt_update 'update_sources' do
  action :update
end



# Install ngnix
package 'nginx'

service 'nginx' do
  action [ :enable, :start ]
end
# Testing6
# template 'destination' do
#   source 'name_file_in_templates.conf.erb'
# end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables(proxy_port: node['nginx']['proxy_port_3000'],
    proxy_port_2: node['nginx']['proxy_port_for_8080'])
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

# include_recipe 'apt'
include_recipe 'nodejs'

nodejs_npm 'pm2'

# Install python for mongodb
# python_runtime 'python3' do
# version '3.5'
# end


# Install mongodb

# node.default['mongodb']['package_version'] = '3.4'
# include_recipe 'mongodb::default'
