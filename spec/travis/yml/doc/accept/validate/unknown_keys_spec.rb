describe Travis::Yml, 'unknown_keys', line: true do
  subject { described_class.load(build_part(yaml, '.travis.yml'), opts) }

  describe 'given a known key' do
    yaml 'language: ruby'
    it { should serialize_to language: 'ruby' }
    it { should_not have_msg }
  end

  describe 'given an unknown key' do
    yaml 'unknown: str'

    describe 'drop turned off (default)' do
      it { should serialize_to unknown: 'str' }
      it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str', line: 0, src: '.travis.yml'] }
    end

    describe 'drop turned on', drop: true do
      it { should serialize_to empty }
      it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str', line: 0, src: '.travis.yml'] }
    end
  end

  describe 'given an unknown key has an anchor' do
    yaml <<~yaml
      unknown: &ref
        script: ./str
      <<: *ref
    yaml
    it { should serialize_to unknown: { script: './str' }, script: ['./str'] }
    it { should have_msg [:warn, :root, :deprecated_key, key: 'unknown', info: 'anchor on a non-private key', line: 0, src: '.travis.yml'] }
  end
end
