describe Travis::Yml, 'cache' do
  let(:types) { Travis::Yml::Schema::Def::Cache::TYPES }

  subject { described_class.apply(parse(yaml), opts) }

  describe 'given true', drop: true do
    yaml %(
      cache: true
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :cache, :unknown_value, value: true] }
  end

  describe 'given false' do
    yaml %(
      cache: false
    )
    it { should serialize_to cache: false }
    it { should_not have_msg }
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

  describe 'given a seq' do
    describe 'known values' do
      yaml %(
        cache:
          - apt
          - bundler
      )
      it { should serialize_to cache: { apt: true, bundler: true } }
      it { should_not have_msg }
    end

    describe 'known values and directories' do
      yaml %(
        cache:
          - apt: true
            directories:
            - foo
      )
      it { should serialize_to cache: { apt: true, directories: ['foo'] } }
      it { should_not have_msg }
    end

    describe 'known value on a map' do
      yaml %(
        cache:
          - apt: true
      )
      it { should serialize_to cache: { apt: true } }
      it { should_not have_msg }
    end

    describe 'directory map' do
      yaml %(
        cache:
          - directories: foo
      )
      it { should serialize_to cache: { directories: ['foo'] } }
      it { should_not have_msg }
    end

    describe 'unknown values' do
      yaml %(
        cache:
          - foo
          - bar
      )
      it { should serialize_to cache: { directories: ['foo', 'bar'] } }
      it { should_not have_msg }
    end

    describe 'mixed known and unknown values' do
      yaml %(
        cache:
          - apt
          - foo
          - bar
      )
      it { should serialize_to cache: { apt: true, directories: ['foo', 'bar'] } }
      it { should_not have_msg }
    end

    describe 'known and unknown keys on maps' do
      yaml %(
        cache:
          - apt: true
          - unknown: true
      )
      it { should serialize_to cache: { apt: true, unknown: true } }
      it { should have_msg [:warn, :cache, :unknown_key, key: 'unknown', value: true] }
    end
  end

  describe 'given a map' do
    describe 'bundler' do
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
      it { should have_msg [:warn, :cache, :find_key, original: 'directory', key: 'directories'] }
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
        it { should_not have_msg }
      end

      describe 'given a string' do
        yaml %(
          cache:
            edge: on
        )
        it { should serialize_to cache: { edge: true } }
        it { should_not have_msg }
      end
    end
  end
end
