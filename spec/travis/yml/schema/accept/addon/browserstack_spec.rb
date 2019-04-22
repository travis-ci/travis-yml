require 'json'

describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }
  describe 'browserstack' do
    describe 'username' do
      it { should validate addons: { browserstack: { username: 'str' } } }

      it { should_not validate addons: { browserstack: { username: true } } }
      it { should_not validate addons: { browserstack: { username: ['str'] } } }
      it { should_not validate addons: { browserstack: { username: 1 } } }
      it { should_not validate addons: { browserstack: { username: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { username: [ name: 'str' ] } } }
    end

    describe 'access_key' do
      it { should validate addons: { browserstack: { access_key: 'str' } } }

      it { should_not validate addons: { browserstack: { access_key: 1 } } }
      it { should_not validate addons: { browserstack: { access_key: true } } }
      it { should_not validate addons: { browserstack: { access_key: ['str'] } } }
      it { should_not validate addons: { browserstack: { access_key: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { access_key: [ name: 'str' ] } } }
    end

    describe 'forcelocal' do
      it { should validate addons: { browserstack: { forcelocal: true } } }

      it { should_not validate addons: { browserstack: { forcelocal: 1 } } }
      it { should_not validate addons: { browserstack: { forcelocal: 'str' } } }
      it { should_not validate addons: { browserstack: { forcelocal: ['str'] } } }
      it { should_not validate addons: { browserstack: { forcelocal: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { forcelocal: [ name: 'str' ] } } }
    end

    describe 'only' do
      it { should validate addons: { browserstack: { only: 'str' } } }

      it { should_not validate addons: { browserstack: { only: 1 } } }
      it { should_not validate addons: { browserstack: { only: true } } }
      it { should_not validate addons: { browserstack: { only: ['str'] } } }
      it { should_not validate addons: { browserstack: { only: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { only: [ name: 'str' ] } } }
    end

    describe 'proxyHost' do
      it { should validate addons: { browserstack: { proxyHost: 'str' } } }

      it { should_not validate addons: { browserstack: { proxyHost: 1 } } }
      it { should_not validate addons: { browserstack: { proxyHost: true } } }
      it { should_not validate addons: { browserstack: { proxyHost: ['str'] } } }
      it { should_not validate addons: { browserstack: { proxyHost: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { proxyHost: [ name: 'str' ] } } }
    end

    describe 'proxyPort' do
      it { should validate addons: { browserstack: { proxyPort: 'str' } } }

      it { should_not validate addons: { browserstack: { proxyPort: 1 } } }
      it { should_not validate addons: { browserstack: { proxyPort: true } } }
      it { should_not validate addons: { browserstack: { proxyPort: ['str'] } } }
      it { should_not validate addons: { browserstack: { proxyPort: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { proxyPort: [ name: 'str' ] } } }
    end

    describe 'proxyUser' do
      it { should validate addons: { browserstack: { proxyUser: 'str' } } }

      it { should_not validate addons: { browserstack: { proxyUser: 1 } } }
      it { should_not validate addons: { browserstack: { proxyUser: true } } }
      it { should_not validate addons: { browserstack: { proxyUser: ['str'] } } }
      it { should_not validate addons: { browserstack: { proxyUser: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { proxyUser: [ name: 'str' ] } } }
    end

    describe 'proxyPass' do
      it { should validate addons: { browserstack: { proxyPass: 'str' } } }

      it { should_not validate addons: { browserstack: { proxyPass: 1 } } }
      it { should_not validate addons: { browserstack: { proxyPass: true } } }
      it { should_not validate addons: { browserstack: { proxyPass: ['str'] } } }
      it { should_not validate addons: { browserstack: { proxyPass: { name: 'str' } } } }
      it { should_not validate addons: { browserstack: { proxyPass: [ name: 'str' ] } } }
    end
  end
end
