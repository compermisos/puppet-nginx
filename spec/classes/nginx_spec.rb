require 'spec_helper'

describe 'nginx' do
  let :params do
    {
      :nginx_upstreams => { 'upstream1' => { 'members' => ['localhost:3000']} },
      :nginx_vhosts    => { 'test2.local' => { 'www_root' => '/' } },
      :nginx_locations => { 'test2.local' => { 'vhost' => 'test2.local', 'www_root' => '/'} }
    }
  end

  shared_examples "a Linux OS" do
    it { should contain_nginx__package }
    it { should contain_nginx__config }
    it { should contain_nginx__service }
    it { should contain_class("nginx::params") }
    it { should contain_nginx__resource__upstream("upstream1") }
    it { should contain_nginx__resource__vhost("test2.local") }
    it { should contain_nginx__resource__location("test2.local") }
  end

  context "Debian OS" do
    it_behaves_like "a Linux OS" do
      let :facts do
        {
          :operatingsystem => 'Debian',
          :osfamily        => 'Debian',
          :lsbdistcodename => 'precise',
        }
      end
    end
  end

  context "RedHat OS" do
    it_behaves_like "a Linux OS" do
      let :facts do
        {
          :operatingsystem => 'RedHat',
          :osfamily        => 'RedHat',
        }
      end
    end
  end

  context "Suse OS" do
    it_behaves_like "a Linux OS" do
      let :facts do
        {
          :operatingsystem => 'SuSE',
          :osfamily        => 'Suse',
        }
      end
    end
  end
end
