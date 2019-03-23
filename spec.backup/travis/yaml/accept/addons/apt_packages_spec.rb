describe Travis::Yaml, 'addon: apt_packages' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'given a string' do
    let(:config) { { addons: { apt_packages: 'curl' } } }
    it { expect(addons[:apt_packages]).to eq ['curl'] }
  end

  describe 'given an array' do
    let(:config) { { addons: { apt_packages: ['curl', 'git'] } } }
    it { expect(addons[:apt_packages]).to eq ['curl', 'git'] }
  end
end
