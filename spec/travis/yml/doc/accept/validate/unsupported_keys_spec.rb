describe Travis::Yml, 'unsupported_keys' do
  subject { described_class.apply(value) }

  describe 'given a supported key' do
    let(:value) { { os: ['osx'], osx_image: 'str' } }
    it { should serialize_to os: ['osx'], osx_image: 'str' }
    it { should_not have_msg [:warn, :osx_image, :unsupported, on_key: :os, on_value: 'osx', key: :osx_image, value: 'str'] }
  end

  describe 'given an unknown key' do
    let(:value) { { os: ['linux'], osx_image: 'str' } }
    it { should serialize_to os: ['linux'], osx_image: 'str' }
    it { should have_msg [:warn, :osx_image, :unsupported, on_key: :os, on_value: 'linux', key: :osx_image, value: 'str'] }
  end
end
