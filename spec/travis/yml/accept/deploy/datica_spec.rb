describe Travis::Yml, 'datica' do
  subject { described_class.load(yaml) }

  describe 'target' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: datica
          target: str
      )
      it { should serialize_to deploy: [provider: 'datica', target: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'path' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: datica
          path: str
      )
      it { should serialize_to deploy: [provider: 'datica', path: 'str'] }
      it { should_not have_msg }
    end
  end
end
