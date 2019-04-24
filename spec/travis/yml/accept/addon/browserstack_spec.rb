describe Travis::Yml, 'addon: browserstack' do
  subject { described_class.apply(parse(yaml)) }
  describe 'username' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            username: str
      )
      it { should serialize_to addons: { browserstack: { username: 'str' } } }
      it { should_not have_msg }
    end
  end

  describe 'access_key' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            access_key: str
      )
      it { should serialize_to addons: { browserstack: { access_key: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a secure' do
      yaml %(
        addons:
          browserstack:
            access_key:
              secure: str
      )
      it { should serialize_to addons: { browserstack: { access_key: { secure: 'str' } } } }
      it { should_not have_msg }
    end
  end

  describe 'forcelocal' do
    describe 'given a bool' do
      yaml %(
        addons:
          browserstack:
            forcelocal: true
      )
      it { should serialize_to addons: { browserstack: { forcelocal: true } } }
      it { should_not have_msg }
    end
  end

  describe 'only' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            only: str
      )
      it { should serialize_to addons: { browserstack: { only: 'str' } } }
      it { should_not have_msg }
    end
  end

  describe 'app_path' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            app_path: str
      )
      it { should serialize_to addons: { browserstack: { app_path: 'str' } } }
      it { should_not have_msg }
    end
  end

  describe 'proxyHost' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            proxyHost: str
      )
      it { should serialize_to addons: { browserstack: { proxyHost: 'str' } } }
      it { should_not have_msg }
    end
  end

  describe 'proxyPort' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            proxyPort: str
      )
      it { should serialize_to addons: { browserstack: { proxyPort: 'str' } } }
      it { should_not have_msg }
    end
  end

  describe 'proxyUser' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            proxyUser: str
      )
      it { should serialize_to addons: { browserstack: { proxyUser: 'str' } } }
      it { should_not have_msg }
    end
  end

  describe 'proxyPass' do
    describe 'given a str' do
      yaml %(
        addons:
          browserstack:
            proxyPass: str
      )
      it { should serialize_to addons: { browserstack: { proxyPass: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a secure' do
      yaml %(
        addons:
          browserstack:
            proxyPass:
              secure: str
      )
      it { should serialize_to addons: { browserstack: { proxyPass: { secure: 'str' } } } }
      it { should_not have_msg }
    end
  end
end
