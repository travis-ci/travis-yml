describe Travis::Yml, 'bluemixcf' do
  subject { described_class.apply(parse(yaml)) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: bluemixcf
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: bluemixcf
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'organization' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcf
          organization: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', organization: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'api' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcf
          api: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', api: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'space' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcf
          space: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', space: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcf
          region: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'manifest' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bluemixcf
          manifest: str
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', manifest: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'skip_ssl_validation' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: bluemixcf
          skip_ssl_validation: true
      )
      it { should serialize_to deploy: [provider: 'bluemixcf', skip_ssl_validation: true] }
      it { should_not have_msg }
    end
  end
end
