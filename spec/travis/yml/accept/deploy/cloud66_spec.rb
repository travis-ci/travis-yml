describe Travis::Yml, 'cloud66' do
  subject { described_class.apply(parse(yaml)) }

  describe 'redeployment_hook' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloud66
          redeployment_hook: str
      )
      it { should serialize_to deploy: [provider: 'cloud66', redeployment_hook: 'str'] }
      it { should_not have_msg }
    end
  end
end
