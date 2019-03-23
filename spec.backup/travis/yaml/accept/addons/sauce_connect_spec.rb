describe Travis::Yaml, 'addon: sauce_connect' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'given true' do
    let(:config) { { addons: { sauce_connect: true } } }
    it { expect(addons[:sauce_connect]).to eq(enabled: true) }
  end

  describe 'given a hash' do
    let(:config) { { addons: { sauce_connect: { username: 'foo' } } } }
    it { expect(addons[:sauce_connect]).to eq(enabled: true, username: 'foo') }
  end

  describe 'given a nested, misplaced hash' do
    let(:config) { { addons: { sauce_connect: { sauce_connect: true } } } }
    it { expect(addons[:sauce_connect]).to eq(enabled: true) }
    it { expect(msgs).to include [:warn, :'addons.sauce_connect', :migrate, key: :sauce_connect, to: :addons, value: true] }
  end
end
