describe Travis::Yml, 'surge', alert: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'login' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: surge
          login:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'surge', login: { secure: secure }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: surge
          login: str
      )
      it { should serialize_to deploy: [provider: 'surge', login: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: surge
          token:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'surge', token: { secure: secure }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: surge
          token: str
      )
      it { should serialize_to deploy: [provider: 'surge', token: 'str'] }
      it { should have_msg [:alert, :'deploy.token', :secure, type: :str] }
    end
  end

  describe 'project' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: surge
          project: str
      )
      it { should serialize_to deploy: [provider: 'surge', project: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'domain' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: surge
          domain: str
      )
      it { should serialize_to deploy: [provider: 'surge', domain: 'str'] }
      it { should_not have_msg }
    end
  end
end
