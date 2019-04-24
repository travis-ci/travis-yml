describe Travis::Yml, 'cargo' do
  subject { described_class.apply(parse(yaml)) }

  describe 'token' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cargo
          token: str
      )
      it { should serialize_to deploy: [provider: 'cargo', token: 'str'] }
      it { should_not have_msg }
    end

    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cargo
          token:
            secure: str
      )
      it { should serialize_to deploy: [provider: 'cargo', token: { secure: 'str' }] }
      it { should_not have_msg }
    end
  end
end
