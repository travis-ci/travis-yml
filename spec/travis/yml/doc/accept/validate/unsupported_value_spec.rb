describe Travis::Yml, 'unsupported_keys' do
  subject { described_class.apply(value) }

  describe 'given a supported value' do
    let(:value) { { os: 'linux', dist: 'trusty' } }
    it { should serialize_to os: ['linux'], dist: 'trusty' }
    it { should_not have_msg }
  end

  describe 'given an unknown key' do
    let(:value) { { os: 'osx', dist: 'trusty' } }
    it { should serialize_to os: ['osx'], dist: 'trusty' }
    it { should have_msg [:warn, :dist, :unsupported, on_key: :os, on_value: 'osx', key: :dist, value: 'trusty'] }
  end
end
