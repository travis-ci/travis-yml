describe Travis::Yml, 'transifex', alert: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: transifex
          username:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'transifex', username: { secure: secure }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: transifex
          username: str
      )
      it { should serialize_to deploy: [provider: 'transifex', username: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: transifex
          password:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'transifex', password: { secure: secure }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: transifex
          password: str
      )
      it { should serialize_to deploy: [provider: 'transifex', password: 'str'] }
      it { should have_msg [:alert, :'deploy.password', :secure, type: :str] }
    end
  end

  describe 'hostname' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: transifex
          hostname: str
      )
      it { should serialize_to deploy: [provider: 'transifex', hostname: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'cli_version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: transifex
          cli_version: str
      )
      it { should serialize_to deploy: [provider: 'transifex', cli_version: 'str'] }
      it { should_not have_msg }
    end
  end
end
