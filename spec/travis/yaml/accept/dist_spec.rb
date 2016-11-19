describe Travis::Yaml, 'dist' do
  let(:msgs) { subject.msgs }
  let(:dist) { subject.to_h[:dist] }

  subject { described_class.apply(config) }

  describe 'defaults to precise' do
    let(:config) { {} }
    it { expect(dist).to eq 'precise' }
  end

  describe 'sets a dist value' do
    let(:config) { { dist: 'trusty' } }
    it { expect(dist).to eq 'trusty' }
  end

  describe 'ignores case' do
    let(:config) { { dist: 'TRUSTY' } }
    it { expect(dist).to eq 'trusty' }
  end

  describe 'drops an unknown dist' do
    let(:config) { { dist: 'unknown' } }
    it { expect(dist).to eq 'precise' }
    it { expect(msgs).to include([:warn, :dist, :unknown_default, 'dropping unknown value "unknown", defaulting to "precise"']) }
  end

  describe 'supports aliases' do
    let(:config) { { dist: 'macos' } }
    it { expect(dist).to eq 'osx' }
  end

  describe 'supports arrays, but warns' do
    let(:config) { { dist: ['trusty'] } }
    it { expect(dist).to eq 'trusty' }
    it { expect(msgs).to include([:warn, :dist, :invalid_seq, 'unexpected sequence, using the first value ("trusty")']) }
  end
end
