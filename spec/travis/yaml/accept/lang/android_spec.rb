describe Travis::Yaml do
  let(:config)  { subject.serialize }
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
      it { expect(msgs).to include [:error, :android, :unsupported, on_key: :language, on_value: 'go', key: :android, value: { components: ['foo'] }] }
    end
  end

  describe 'android' do
    describe 'given an array of hashes' do
      let(:input) { { language: 'android', android: [{ components: ['foo'] }, { components: ['bar'] }] } }
      it { expect(android).to eq components: ['foo', 'bar'] }
      it { expect(msgs).to include [:warn, :android, :invalid_seq, value: { components: ['foo', 'bar'] }] }
    end

    describe 'given an array of hashes with unknown keys' do
      let(:input) { { language: 'android', android: [{ target: 'android-8' }, { target: 'android-10' }] } }
      it { expect(android).to be_nil }
      it { expect(msgs).to include [:warn, :android, :invalid_seq, value: { target: 'android-8' }] }
    end
  end
end
