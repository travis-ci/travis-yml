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

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: npm
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'npm', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end
end
