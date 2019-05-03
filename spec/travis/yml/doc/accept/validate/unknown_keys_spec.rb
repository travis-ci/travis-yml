describe Travis::Yml, 'unknown_keys', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given a known key' do
    yaml 'language: ruby'
    it { should serialize_to language: 'ruby' }
    it { should_not have_msg }
  end

  describe 'given an unknown key' do
    yaml 'unknown: str'
    it { should serialize_to unknown: 'str' }
    it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str', line: 0] }
  end

  describe 'given an unknown key has an anchor' do
    yaml %(
      unknown: &ref
        script: ./str
      <<: *ref
    )
    it { should serialize_to unknown: { script: './str' }, script: ['./str'] }
    it { should have_msg [:warn, :root, :deprecated_key, key: 'unknown', info: 'anchor on a non-private key'] }
  end
end
