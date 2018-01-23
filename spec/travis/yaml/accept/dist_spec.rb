describe Travis::Yaml, 'dist' do
  let(:dist) { subject.serialize[:dist] }

  subject { described_class.apply(config) }

  describe 'defaults to trusty' do
    let(:config) { {} }
    it { expect(dist).to eq 'trusty' }
  end

  describe 'sets a dist value' do
    let(:config) { { dist: 'precise' } }
    it { expect(dist).to eq 'precise' }
  end

  describe 'ignores case' do
    let(:config) { { dist: 'TRUSTY' } }
    it { expect(dist).to eq 'trusty' }
  end

  describe 'drops an unknown dist' do
    let(:config) { { dist: 'unknown' } }
    it { expect(dist).to eq 'trusty' }
    it { expect(msgs).to include([:warn, :dist, :unknown_default, value: 'unknown', default: 'trusty']) }
  end

  describe 'supports aliases' do
    let(:config) { { dist: 'macos' } }
    it { expect(dist).to eq 'osx' }
  end

  describe 'supports arrays, but warns' do
    let(:config) { { dist: ['trusty'] } }
    it { expect(dist).to eq 'trusty' }
    it { expect(msgs).to include([:warn, :dist, :invalid_seq, value: 'trusty']) }
  end
end
