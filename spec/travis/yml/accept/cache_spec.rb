describe Travis::Yml, 'cache' do
  let(:types) { Travis::Yml::Schema::Def::Cache::TYPES }

  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      cache: true
    )
    it { should serialize_to cache: types.map { |type| [type, true] }.to_h }
    it { should have_msg [:warn, :cache, :deprecated, deprecation: :cache_enable_all, value: true] }
  end

  describe 'given false' do
    yaml %(
      cache: false
    )
    it { should serialize_to cache: types.map { |type| [type, false] }.to_h }
    it { should have_msg [:warn, :cache, :deprecated, deprecation: :cache_enable_all, value: false] }
  end

  describe 'given a string' do
    yaml %(
      cache: apt
    )
    it { should serialize_to cache: { apt: true } }
    it { should_not have_msg }
  end

  describe 'given a string with a typo' do
    yaml %(
      cache: ':apt'
    )
    it { should serialize_to cache: { apt: true } }
    it { should have_msg [:info, :cache, :find_value, original: ':apt', value: 'apt'] }
  end

  describe 'given an unknown string' do
    yaml %(
      cache: foo
    )
    it { should serialize_to cache: { directories: ['foo'] } }
    it { should_not have_msg }
  end

  describe 'given a seq of known values' do
    yaml %(
      cache:
        - apt
        - bundler
    )
    it { should serialize_to cache: { apt: true, bundler: true } }
    it { should_not have_msg }
  end

  describe 'given a seq of known values and directories' do
    yaml %(
      cache:
        - apt: true
          directories:
          - foo
    )
    it { should serialize_to cache: { apt: true, directories: ['foo'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with a map with a known type' do
    yaml %(
      cache:
        - apt: true
    )
    it { should serialize_to cache: { apt: true } }
    it { should_not have_msg }
  end

  describe 'given a seq with a directory map' do
    yaml %(
      cache:
        - directories: foo
    )
    it { should serialize_to cache: { directories: ['foo'] } }
    it { should_not have_msg }
  end

  describe 'given a seq of unknown values' do
    yaml %(
      cache:
        - foo
        - bar
    )
    it { should serialize_to cache: { directories: ['foo', 'bar'] } }
    it { should_not have_msg }
  end

  describe 'given a seq of mixed known and unknown values' do
    yaml %(
      cache:
        - apt
        - foo
        - bar
    )
    it { should serialize_to cache: { apt: true, directories: ['foo', 'bar'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with known and unknown keys on maps' do
    yaml %(
      cache:
        - apt: true
        - unknown: true
    )
    it { should serialize_to cache: { apt: true, unknown: true } }
    it { should have_msg [:warn, :cache, :unknown_key, key: :unknown, value: true] }
  end

  describe 'given a map' do
    yaml %(
      cache:
        bundler: true
    )
    it { should serialize_to cache: { bundler: true } }
    it { should_not have_msg }
  end

  describe 'directories' do
    describe 'given a string' do
      yaml %(
        cache:
          directories: foo
      )
      it { should serialize_to cache: { directories: ['foo'] } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        cache:
          directories:
            - foo
      )
      it { should serialize_to cache: { directories: ['foo'] } }
      it { should_not have_msg }
    end

    describe 'mixed with a known type' do
      yaml %(
        cache:
          bundler: true
          directories:
            - foo
      )
      it { should serialize_to cache: { bundler: true, directories: ['foo'] } }
      it { should_not have_msg }
    end
  end

  describe 'directory (alias)' do
    yaml %(
      cache:
        directory: foo
    )
    it { should serialize_to cache: { directories: ['foo'] } }
    it { should have_msg [:warn, :cache, :find_key, original: :directory, key: :directories] }
  end

  describe 'branch' do
    yaml %(
      cache:
        branch: master
    )
    it { should serialize_to cache: { branch: 'master' } }
  end

  describe 'edge' do
    describe 'given a bool' do
      yaml %(
        cache:
          edge: true
      )
      it { should serialize_to cache: { edge: true } }
      it { should have_msg [:info, :'cache.edge', :edge] }
    end

    describe 'given a string' do
      yaml %(
        cache:
          edge: on
      )
      it { should serialize_to cache: { edge: true } }
      it { should have_msg [:info, :'cache.edge', :edge] }
    end
  end
end
