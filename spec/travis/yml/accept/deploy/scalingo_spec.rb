describe Travis::Yml, 'scalingo' do
  subject { described_class.load(yaml) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: scalingo
          username:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'scalingo', username: { secure: secure }] }
      it { should_not have_msg }
      it { should_not have_msg }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: scalingo
          password:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'scalingo', password: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'api_token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: scalingo
          api_token:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'scalingo', api_token: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: scalingo
          api_key:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'scalingo', api_token: { secure: secure }] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'api_key', key: 'api_token', provider: 'scalingo'] }
      xit { should have_msg [:warn, :deploy, :deprecated_key, :api_key] }
    end
  end

  describe 'remote' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: scalingo
          remote: str
      )
      it { should serialize_to deploy: [provider: 'scalingo', remote: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'branch' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: scalingo
          branch: str
      )
      it { should serialize_to deploy: [provider: 'scalingo', branch: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: scalingo
          app: str
      )
      it { should serialize_to deploy: [provider: 'scalingo', app: 'str'] }
      it { should_not have_msg }
    end
  end
end
