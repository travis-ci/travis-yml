describe Travis::Yml, 'cloudcontrol' do
  subject { described_class.apply(parse(yaml)) }

  describe 'email' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudcontrol
          email:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudcontrol', email: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudcontrol
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudcontrol', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'deployment' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudcontrol
          deployment: str
      )
      it { should serialize_to deploy: [provider: 'cloudcontrol', deployment: 'str'] }
      it { should_not have_msg }
    end
  end
end
