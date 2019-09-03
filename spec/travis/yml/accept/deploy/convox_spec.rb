describe Travis::Yml, 'convox' do
  subject { described_class.apply(parse(yaml)) }

  describe 'host' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          host: str
      )
      it { should serialize_to deploy: [provider: 'convox', host: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          app: str
      )
      it { should serialize_to deploy: [provider: 'convox', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'rack' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          rack: str
      )
      it { should serialize_to deploy: [provider: 'convox', rack: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: convox
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'convox', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'install_url' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          install_url: str
      )
      it { should serialize_to deploy: [provider: 'convox', install_url: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'update_cli' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: convox
          update_cli: true
      )
      it { should serialize_to deploy: [provider: 'convox', update_cli: true] }
      it { should_not have_msg }
    end
  end

  describe 'create' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: convox
          create: true
      )
      it { should serialize_to deploy: [provider: 'convox', create: true] }
      it { should_not have_msg }
    end
  end

  describe 'promote' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: convox
          promote: true
      )
      it { should serialize_to deploy: [provider: 'convox', promote: true] }
      it { should_not have_msg }
    end
  end

  describe 'env' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: convox
          env:
          - str
      )
      it { should serialize_to deploy: [provider: 'convox', env: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'env_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          env_file: str
      )
      it { should serialize_to deploy: [provider: 'convox', env_file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'description' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          description: str
      )
      it { should serialize_to deploy: [provider: 'convox', description: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'generation' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: convox
          generation: 1
      )
      it { should serialize_to deploy: [provider: 'convox', generation: 1] }
      it { should_not have_msg }
    end
  end
end
