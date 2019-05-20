describe Travis::Yml, 'engineyard' do
  subject { described_class.apply(parse(yaml)) }

  describe 'email' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: engineyard
          email:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'engineyard', email: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: engineyard
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'engineyard', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: engineyard
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'engineyard', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: engineyard
          app: str
      )
      it { should serialize_to deploy: [provider: 'engineyard', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a map' do
      yaml %(
        deploy:
          provider: engineyard
          app:
            master: one
      )
      it { should serialize_to deploy: [provider: 'engineyard', app: { master: 'one' }] }
      it { should_not have_msg }
    end
  end

  describe 'environment' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: engineyard
          environment:
            master: staging
      )
      it { should serialize_to deploy: [provider: 'engineyard', environment: { master: 'staging' }] }
      it { should_not have_msg }
    end
  end

  describe 'migrate' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: engineyard
          migrate: str
      )
      it { should serialize_to deploy: [provider: 'engineyard', migrate: 'str'] }
      it { should_not have_msg }
    end
  end
end
