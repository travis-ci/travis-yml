describe Travis::Yml, 'catalyze' do
  subject { described_class.apply(parse(yaml)) }

  describe 'target' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: catalyze
          target: str
      )
      it { should serialize_to deploy: [provider: 'catalyze', target: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'path' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: catalyze
          path: str
      )
      it { should serialize_to deploy: [provider: 'catalyze', path: 'str'] }
      it { should_not have_msg }
    end
  end
end
