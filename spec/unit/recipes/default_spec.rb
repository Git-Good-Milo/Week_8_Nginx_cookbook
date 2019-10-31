#
# Cookbook:: node03
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node03::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '16.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    it 'enables the nginx service' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'Starts the nginx service' do
      expect(chef_run).to start_service 'nginx'
    end

    it 'Should install nodejs from a recipe' do
      expect(chef_run).to include_recipe 'nodejs'
    end

    it 'Should install pm2 from a recipe' do
      expect(chef_run).to install_package 'nodejs'
    end

    # it 'should enable nodejs service' do
    #   expect(chef_run).to enable_service 'nodejs'
    # end
    #
    # it 'should start nodejs service' do
    #   expect(chef_run).to start_service 'nodejs'
    # end

    it 'should create proxy.conf in /etc/nginx/sites-available' do
      expect(chef_run).to create_template "/etc/nginx/sites-available/proxy.conf"
    end

    it 'should create a symlink of proxy.conf from sites-available to sites-enabled' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with_link_type(:symbolic)
    end

    it 'should delete the symlink from the default config in sites-enabled' do
      expect(chef_run).to delete_link "/etc/nginx/sites-enabled/default"
    end

    it 'runs apt get update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it "should create a proxy.cof template in /etc/nginx/sites-available with port 3000" do
      expect(chef_run).to create_template("/etc/nginx/sites-available/proxy.conf").with_variables(proxy_port: 3000, proxy_port_2: 8080)
    end

    # it "should install python3" do
    #   expect(chef_run).to python_runtime ""
    # end



    # it "should install mongodb from a recipe" do
    #   expect(chef_run).to include_recipe 'mongodb::default'
    # end


  end
end
