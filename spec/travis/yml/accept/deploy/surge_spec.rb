describe Travis::Yml, 'surge' do
  subject { described_class.apply(parse(yaml)) }

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
