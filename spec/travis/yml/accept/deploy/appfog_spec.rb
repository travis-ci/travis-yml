describe Travis::Yml, 'appfog' do
  subject { described_class.apply(parse(yaml)) }

  describe 'user' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: appfog
          user:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'appfog', user: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: appfog
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'appfog', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'email' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: appfog
          email: str
      )
      it { should serialize_to deploy: [provider: 'appfog', email: 'str'] }
      it { should_not have_msg }
    end

    describe 'given a map with a str' do
      yaml %(
        deploy:
          provider: appfog
          email:
            production: str
      )
      it { should serialize_to deploy: [provider: 'appfog', email: { production: 'str' }] }
      it { should_not have_msg }
    end

    describe 'given a map with a secure' do
      yaml %(
        deploy:
          provider: appfog
          email:
            production:
              secure: secure
      )
      it { should serialize_to deploy: [provider: 'appfog', email: { production: { secure: 'secure' } }] }
      it { should_not have_msg }
    end

    describe 'given a seq with a str' do
      yaml %(
        deploy:
          provider: appfog
          email:
          - str
      )
      it { should serialize_to deploy: [provider: 'appfog', email: 'str'] }
      it { should have_msg [:warn, :'deploy.email', :invalid_seq, value: 'str'] }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: appfog
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'appfog', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: appfog
          app: str
      )
      it { should serialize_to deploy: [provider: 'appfog', app: 'str'] }
      it { should_not have_msg }
    end

    describe 'given a map with a str' do
      yaml %(
        deploy:
          provider: appfog
          app:
            production: str
      )
      it { should serialize_to deploy: [provider: 'appfog', app: { production: 'str' }] }
      it { should_not have_msg }
    end
  end

  describe 'address' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: appfog
          address:
          - str
      )
      it { should serialize_to deploy: [provider: 'appfog', address: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: appfog
          address: str
      )
      it { should serialize_to deploy: [provider: 'appfog', address: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'metadata' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: appfog
          metadata: str
      )
      it { should serialize_to deploy: [provider: 'appfog', metadata: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'after_deploy' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: appfog
          after_deploy:
          - str
      )
      it { should serialize_to deploy: [provider: 'appfog', after_deploy: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: appfog
          after_deploy: str
      )
      it { should serialize_to deploy: [provider: 'appfog', after_deploy: ['str']] }
      it { should_not have_msg }
    end
  end
end
