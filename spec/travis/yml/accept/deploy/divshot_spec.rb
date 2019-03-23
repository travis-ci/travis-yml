describe Travis::Yml, 'divshot' do
  subject { described_class.apply(parse(yaml)) }

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: divshot
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'divshot', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'environment' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: divshot
          environment: str
      )
      it { should serialize_to deploy: [provider: 'divshot', environment: 'str'] }
      it { should_not have_msg }
    end
  end
end
