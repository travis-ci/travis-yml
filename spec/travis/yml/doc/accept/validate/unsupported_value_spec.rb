describe Travis::Yml, 'unsupported_keys', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given a supported value' do
    yaml %(
      os: linux
      dist: trusty
    )
    it { should serialize_to os: ['linux'], dist: 'trusty' }
    it { should_not have_msg }
  end

  describe 'given an unknown key' do
    yaml %(
      os: osx
      dist: trusty
    )
    it { should serialize_to os: ['osx'], dist: 'trusty' }
    it { should have_msg [:warn, :dist, :unsupported, on_key: 'os', on_value: 'osx', key: 'dist', value: 'trusty', line: 2] }
  end
end
