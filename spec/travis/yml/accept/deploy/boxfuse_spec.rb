describe Travis::Yml, 'boxfuse' do
  subject { described_class.load(yaml) }

  describe 'user' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: boxfuse
          user:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'boxfuse', user: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: boxfuse
          secret:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'boxfuse', secret: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'config_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          config_file: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', config_file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'configfile (alias)' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          configfile: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', config_file: 'str'] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'configfile', key: 'config_file', provider: 'boxfuse'] }
      xit { should have_msg [:warn, :deploy, :deprecated_key, :configfile] }
    end
  end

  describe 'payload' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          payload: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', payload: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          app: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          version: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', version: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'env' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          env: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', env: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'extra_args' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: boxfuse
          extra_args: str
      )
      it { should serialize_to deploy: [provider: 'boxfuse', extra_args: 'str'] }
      it { should_not have_msg }
    end
  end
end
