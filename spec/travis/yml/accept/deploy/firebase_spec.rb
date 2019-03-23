describe Travis::Yml, 'firebase' do
  subject { described_class.apply(parse(yaml)) }

  describe 'project' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: firebase
          project: str
      )
      it { should serialize_to deploy: [provider: 'firebase', project: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: firebase
          token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'firebase', token: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'message' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: firebase
          message: str
      )
      it { should serialize_to deploy: [provider: 'firebase', message: 'str'] }
      it { should_not have_msg }
    end
  end
end
