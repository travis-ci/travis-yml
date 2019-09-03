describe Travis::Yml, 'npm' do
  subject { described_class.apply(parse(yaml)) }

  describe 'email' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: npm
          email:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'npm', email: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: npm
          api_token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'npm', api_token: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'src' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: npm
          src: str
      )
      it { should serialize_to deploy: [provider: 'npm', src: 'str'] }
      it { should_not have_msg }
    end
  end
end
