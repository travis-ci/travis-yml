describe Travis::Yml, 'cloudfoundry' do
  subject { described_class.load(yaml) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudfoundry
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudfoundry
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'organization' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudfoundry
          organization: str
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', organization: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'api' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudfoundry
          api: str
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', api: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'space' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudfoundry
          space: str
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', space: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'manifest' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudfoundry
          manifest: str
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', manifest: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'skip_ssl_validation' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: cloudfoundry
          skip_ssl_validation: true
      )
      it { should serialize_to deploy: [provider: 'cloudfoundry', skip_ssl_validation: true] }
      it { should_not have_msg }
    end
  end
end
