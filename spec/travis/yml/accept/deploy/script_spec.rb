describe Travis::Yml, 'script' do
  subject { described_class.apply(parse(yaml)) }

  describe 'script' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: script
          script: str
      )
      it { should serialize_to deploy: [provider: 'script', script: 'str'] }
      it { should_not have_msg }
    end
  end
end
