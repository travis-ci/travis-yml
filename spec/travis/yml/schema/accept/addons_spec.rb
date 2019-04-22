describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'addons' do
    describe 'apt_packages' do
      it { should validate addons: { apt_packages: 'curl' } }
      it { should validate addons: { apt_packages: ['curl'] } }

      it { should_not validate addons: { apt_packages: 1 } }
      it { should_not validate addons: { apt_packages: true } }
      it { should_not validate addons: { apt_packages: { name: 'curl' } } }
      it { should_not validate addons: { apt_packages: [ name: 'curl' ] } }
    end

    describe 'hostname' do
      it { should validate addons: { hostname: 'host' } }

      it { should_not validate addons: { hostname: 1 } }
      it { should_not validate addons: { hostname: true } }
      it { should_not validate addons: { hostname: ['host'] } }
      it { should_not validate addons: { hostname: { name: 'host' } } }
      it { should_not validate addons: { hostname: [ name: 'host' ] } }
    end

    describe 'hosts' do
      it { should validate addons: { hosts: 'host' } }
      it { should validate addons: { hosts: ['host'] } }

      it { should_not validate addons: { hosts: 1 } }
      it { should_not validate addons: { hosts: true } }
      it { should_not validate addons: { hosts: { name: 'host' } } }
      it { should_not validate addons: { hosts: [ name: 'host' ] } }
    end

    describe 'ssh_known_hosts' do
      it { should validate addons: { ssh_known_hosts: 'host' } }
      it { should validate addons: { ssh_known_hosts: ['host'] } }

      it { should_not validate addons: { ssh_known_hosts: 1 } }
      it { should_not validate addons: { ssh_known_hosts: true } }
      it { should_not validate addons: { ssh_known_hosts: { name: 'host' } } }
      it { should_not validate addons: { ssh_known_hosts: [ name: 'host' ] } }
    end

    %i(firefox mariadb postgresql rethinkdb).each do |addon|
      describe addon.to_s do
        it { should validate addons: { addon => 'foo' } }

        it { should_not validate addons: { addon => 1 } }
        it { should_not validate addons: { addon => true } }
        it { should_not validate addons: { addon => ['foo'] } }
        it { should_not validate addons: { addon => { name: 'foo' } } }
        it { should_not validate addons: { addon => [ name: 'foo' ] } }
      end
    end
  end
end
