describe Travis::Yaml, 'addon: sauce_connect' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'sauce_connect' do
    describe 'given true' do
      let(:config) { { addons: { sauce_connect: true } } }
      it { expect(addons[:sauce_connect]).to eq(enabled: true) }
    end

    describe 'given a hash' do
      let(:config) { { addons: { sauce_connect: { username: 'foo' } } } }
      it { expect(addons[:sauce_connect]).to eq(enabled: true, username: 'foo') }
    end
  end
end
