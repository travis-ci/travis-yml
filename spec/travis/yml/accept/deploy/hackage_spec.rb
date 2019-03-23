describe Travis::Yml, 'hackage' do
  subject { described_class.apply(parse(yaml)) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: hackage
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'hackage', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: hackage
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'hackage', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end
end
