describe Travis::Yaml do
  let(:msgs)    { subject.msgs }
  let(:config)  { subject.to_h }
  let(:android) { config[:android] }

  subject { described_class.apply(input) }

  describe 'components' do
    describe 'accepts a string' do
      let(:input) { { language: 'android', android: { components: 'foo' }} }
      it { expect(android[:components]).to eq ['foo'] }
    end

    describe 'accepts an array' do
      let(:input) { { language: 'android', android: { components: ['foo'] }} }
      it { expect(android[:components]).to eq ['foo'] }
    end
  end

  describe 'licenses' do
    describe 'accepts a string' do
      let(:input) { { language: 'android', android: { licenses: 'foo' }} }
      it { expect(android[:licenses]).to eq ['foo'] }
    end

    describe 'accepts an array' do
      let(:input) { { language: 'android', android: { licenses: ['foo'] }} }
      it { expect(android[:licenses]).to eq ['foo'] }
    end
  end

  describe 'allows jdk' do
    let(:input) { { language: 'android', jdk: '8'} }
    it { expect(config[:jdk]).to eq ['8'] }
  end

  describe 'language: go' do
    describe 'disallows android' do
      let(:input) { { language: 'go', android: { components: ['foo'] } } }
      it { expect(android).to be_nil }
      it { expect(msgs).to include [:error, :android, :unsupported, 'android ({:components=>["foo"]}) is not supported on language "go"'] }
    end
  end
end
