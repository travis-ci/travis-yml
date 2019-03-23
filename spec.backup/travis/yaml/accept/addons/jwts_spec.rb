describe Travis::Yaml, 'addon: jwts' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  # TODO spec with secure string

  describe 'hosts' do
    describe 'given a string' do
      let(:config) { { addons: { jwt: 'foo' } } }
      it { expect(addons[:jwt]).to eq ['foo'] }
    end

    describe 'given an array' do
      let(:config) { { addons: { jwt: ['foo'] } } }
      it { expect(addons[:jwt]).to eq ['foo'] }
    end
  end
end
