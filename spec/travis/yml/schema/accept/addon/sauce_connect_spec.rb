require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'sauce_connect' do
    describe 'enabled' do
      it { should validate addons: { sauce_connect: { enabled: true } } }

      it { should_not validate addons: { sauce_connect: { enabled: 'str' } } }
      it { should_not validate addons: { sauce_connect: { enabled: ['str'] } } }
      it { should_not validate addons: { sauce_connect: { enabled: 1 } } }
      it { should_not validate addons: { sauce_connect: { enabled: { name: 'str' } } } }
      it { should_not validate addons: { sauce_connect: { enabled: [ name: 'str' ] } } }
    end

    describe 'username' do
      it { should validate addons: { sauce_connect: { username: 'str' } } }

      it { should_not validate addons: { sauce_connect: { username: 1 } } }
      it { should_not validate addons: { sauce_connect: { username: true } } }
      it { should_not validate addons: { sauce_connect: { username: ['str'] } } }
      it { should_not validate addons: { sauce_connect: { username: { name: 'str' } } } }
      it { should_not validate addons: { sauce_connect: { username: [ name: 'str' ] } } }
    end

    describe 'access_key' do
      it { should validate addons: { sauce_connect: { access_key: 'str' } } }

      it { should_not validate addons: { sauce_connect: { access_key: 1 } } }
      it { should_not validate addons: { sauce_connect: { access_key: true } } }
      it { should_not validate addons: { sauce_connect: { access_key: ['str'] } } }
      it { should_not validate addons: { sauce_connect: { access_key: { name: 'str' } } } }
      it { should_not validate addons: { sauce_connect: { access_key: [ name: 'str' ] } } }
    end

    describe 'direct_domains' do
      it { should validate addons: { sauce_connect: { direct_domains: 'str' } } }

      it { should_not validate addons: { sauce_connect: { direct_domains: 1 } } }
      it { should_not validate addons: { sauce_connect: { direct_domains: true } } }
      it { should_not validate addons: { sauce_connect: { direct_domains: ['str'] } } }
      it { should_not validate addons: { sauce_connect: { direct_domains: { name: 'str' } } } }
      it { should_not validate addons: { sauce_connect: { direct_domains: [ name: 'str' ] } } }
    end

    describe 'tunnel_domains' do
      it { should validate addons: { sauce_connect: { tunnel_domains: 'str' } } }

      it { should_not validate addons: { sauce_connect: { tunnel_domains: 1 } } }
      it { should_not validate addons: { sauce_connect: { tunnel_domains: true } } }
      it { should_not validate addons: { sauce_connect: { tunnel_domains: ['str'] } } }
      it { should_not validate addons: { sauce_connect: { tunnel_domains: { name: 'str' } } } }
      it { should_not validate addons: { sauce_connect: { tunnel_domains: [ name: 'str' ] } } }
    end

    describe 'no_ssl_bump_domains' do
      it { should validate addons: { sauce_connect: { no_ssl_bump_domains: 'str' } } }

      it { should_not validate addons: { sauce_connect: { no_ssl_bump_domains: 1 } } }
      it { should_not validate addons: { sauce_connect: { no_ssl_bump_domains: true } } }
      it { should_not validate addons: { sauce_connect: { no_ssl_bump_domains: ['str'] } } }
      it { should_not validate addons: { sauce_connect: { no_ssl_bump_domains: { name: 'str' } } } }
      it { should_not validate addons: { sauce_connect: { no_ssl_bump_domains: [ name: 'str' ] } } }
    end
  end
end
