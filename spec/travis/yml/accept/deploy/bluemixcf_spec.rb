describe Travis::Yml, 'bluemixcloudfoundry' do
  subject { described_class.load(yaml) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          username:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', username: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          password:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', password: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'organization' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          organization: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', organization: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'api' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          api: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', api: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'space' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          space: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', space: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          region: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'manifest' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          manifest: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', manifest: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'skip_ssl_validation' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: bluemixcloudfoundry
          skip_ssl_validation: true
      )
      it { should serialize_to deploy: [provider: 'bluemixcloudfoundry', skip_ssl_validation: true] }
      it { should_not have_msg }
    end
  end
end
