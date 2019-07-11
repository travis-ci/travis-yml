describe Travis::Yml, 'unsupported_keys', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given a supported key' do
    yaml %(
      os: osx
      osx_image: str
    )
    it { should serialize_to os: ['osx'], osx_image: ['str'] }
    it { should_not have_msg [:warn, :osx_image, :unsupported, on_key: 'os', on_value: 'osx', key: 'osx_image', value: ['str'], line: 2] }
  end

  describe 'given an unsupported key' do
    yaml %(
      os: linux
      osx_image: str
    )
    it { should serialize_to os: ['linux'], osx_image: ['str'] }
    it { should have_msg [:warn, :osx_image, :unsupported, on_key: 'os', on_value: 'linux', key: 'osx_image', value: ['str'], line: 2] }
  end
end
