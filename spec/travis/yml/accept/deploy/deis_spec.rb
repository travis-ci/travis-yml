describe Travis::Yml, 'deis' do
  subject { described_class.apply(parse(yaml)) }

  describe 'controller' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: deis
          controller: str
      )
      it { should serialize_to deploy: [provider: 'deis', controller: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: deis
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'deis', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: deis
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'deis', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: deis
          app: str
      )
      it { should serialize_to deploy: [provider: 'deis', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'cli_version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: deis
          cli_version: str
      )
      it { should serialize_to deploy: [provider: 'deis', cli_version: 'str'] }
      it { should_not have_msg }
    end
  end
end
