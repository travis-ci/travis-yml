describe Travis::Yml, 'env' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given a var' do
    yaml %(
      env: FOO=foo
    )
    it { should serialize_to env: { jobs: [FOO: 'foo'] } }
    it { should_not have_msg }
  end

  describe 'given an empty var' do
    yaml %(
      env: FOO=
    )
    it { should serialize_to env: { jobs: [FOO: ''] } }
    it { should_not have_msg }
  end

  describe 'given vars on a str' do
    yaml %(
      env: FOO=foo BAR=bar
    )
    it { should serialize_to env: { jobs: [FOO: 'foo', BAR: 'bar'] } }
    it { should_not have_msg }
  end

  describe 'given vars on an array of strs' do
    yaml %(
      env:
        - FOO=foo BAR=bar
        - BAZ=baz
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo', BAR: 'bar' }, { BAZ: 'baz' }] } }
    it { should_not have_msg }
  end

  describe 'given vars on a multiline str' do
    yaml %(
      env:
        FOO=foo
        BAR=bar
    )
    it { should serialize_to env: { jobs: [FOO: 'foo', BAR: 'bar'] } }
    it { should_not have_msg }
  end

  describe 'given an invalid var' do
    yaml %(
      env: FOO="
    )
    it { should serialize_to env: { jobs: [{}] } }
    it { should have_msg [:error, :'env.jobs', :invalid_env_var, var: 'FOO="'] }
  end

  describe 'given a secure' do
    yaml %(
      env:
        secure: secure
    )
    it { should serialize_to env: { jobs: [secure: 'secure'] } }
    it { should_not have_msg }
  end

  describe 'given a seq of vars' do
    yaml %(
      env:
        - FOO=foo
        - BAR=bar
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq with nil' do
    yaml %(
      env:
        -
    )
    it { should serialize_to env: { jobs: [{}] } }
    it { should_not have_msg }
  end

  describe 'given a seq with nil, and valid vars' do
    yaml %(
      env:
        -
        - FOO=foo
        - BAR=bar BAZ=baz
    )
    it { should serialize_to env: { jobs: [{}, { FOO: 'foo' }, { BAR: 'bar', BAZ: 'baz' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq with an empty str, and valid vars' do
    yaml %(
      env:
        - ''
        - FOO=foo
        - BAR=bar BAZ=baz
    )
    it { should serialize_to env: { jobs: [{}, { FOO: 'foo' }, { BAR: 'bar', BAZ: 'baz' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq with a nested seq with vars' do
    yaml %(
      env:
        -
          - FOO=foo
        - BAR=bar
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq with a nested nested seq with vars' do
    yaml %(
      env:
        -
          -
            - FOO=foo
        - BAR=bar
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { should_not have_msg }
  end

  describe 'given a map' do
    yaml %(
      env:
        FOO: foo
        BAR:
          secure: str
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo', BAR: { secure: 'str' } }] } }
    it { should_not have_msg }
  end

  describe 'given a single secure' do
    yaml %(
      env:
        secure: secure
    )
    it { should serialize_to env: { jobs: [{ secure: 'secure' }] } }
    it { should_not have_msg }
  end

  describe 'given a secure and another key' do
    yaml %(
      env:
        secure: secure
        FOO: foo
    )
    it { should serialize_to env: { jobs: [{ secure: 'secure', FOO: 'foo' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq of secures' do
    yaml %(
      env:
        - secure: one
        - secure: two
    )
    it { should serialize_to env: { jobs: [{ secure: 'one' }, { secure: 'two' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq of maps' do
    yaml %(
      env:
        - FOO: foo
        - BAR: bar
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { should_not have_msg }
  end

  describe 'given a seq of maps and secures' do
    yaml %(
      env:
        - FOO: foo
        - BAR: bar
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { should_not have_msg }
  end

  describe 'given a misplaced key', v2: true, migrate: true do
    yaml %(
      env:
        DEBUG: on
    )
    it { should serialize_to env: { jobs: ['DEBUG=on'] } }
    it { should_not have_msg }
  end

  describe 'given a map mixing known, unknown, and misplaced keys', v2: true, migrate: true do
    let(:value) { { env: { FOO: 'foo', jobs: { BAR: 'bar' }, before_script: 'foo' } } }
    # it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { 'before_script=foo' }, { BAR: 'bar' }] } }
    it { should have_msg [:warn, :env, :migrate_keys, keys: [:FOO, :before_script], to: 'jobs'] }
  end

  describe 'given a map mixing known and unknown keys holding arrays', v2: true, migrate: true do
    let(:value) { { env: { general: [FOO: 'foo'], jobs: [BAR: 'bar'] } } }
    it { should serialize_to env: { jobs: [BAR: 'bar', FOO: 'foo'] } }
    it { should have_msg [:warn, :env, :migrate_keys, keys: [:general], to: 'jobs'] }
  end

  describe 'given global' do
    describe 'as a string' do
      yaml %(
        env:
          global: FOO=foo
      )
      it { should serialize_to env: { global: [FOO: 'foo'] } }
      it { should_not have_msg }
    end

    describe 'a seq of strings' do
      yaml %(
        env:
          global:
            - FOO=foo
            - BAR=bar
      )
      it { should serialize_to env: { global: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
      it { should_not have_msg }
    end

    describe 'as a map' do
      yaml %(
        env:
          global:
            FOO: foo
            BAR: bar
      )
      it { should serialize_to env: { global: [{ FOO: 'foo', BAR: 'bar' }] } }
      it { should_not have_msg }
    end

    describe 'given a seq with a map' do
      yaml %(
        env:
          global:
            - FOO: foo
      )
      it { should serialize_to env: { global: [FOO: 'foo'] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps' do
      yaml %(
        env:
          global:
            - FOO: foo
            - BAR: bar
      )
      it { should serialize_to env: { global: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
      it { should_not have_msg }
    end

    describe 'given a misplaced secure on the parent', v2: true, migrate: true do
      yaml %(
        env:
          global:
            secure: secure
            global:
              secure: secure
      )
      it { should serialize_to env: { global: [{ secure: 'secure' }] } }
      it { should have_msg [:warn, :root, :migrate, key: 'global', to: 'env', value: { secure: 'secure' }] }
    end

    describe 'mixing secure and global keys' do
      yaml %(
        env:
          secure: secure
          global:
            secure: secure
      )
      it { should serialize_to env: { jobs: [{ secure: 'secure' }], global: [{ secure: 'secure' }] } }
      it { should_not have_msg }
    end
  end

  describe 'given jobs' do
    describe 'as a string' do
      yaml %(
        env:
          jobs: FOO=foo
      )
      it { should serialize_to env: { jobs: [FOO: 'foo'] } }
      it { should_not have_msg }
    end

    describe 'as a seq of strings' do
      yaml %(
        env:
          jobs:
            - FOO=foo
            - BAR=bar
      )
      it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
      it { should_not have_msg }
    end

    describe 'as a map' do
      yaml %(
        env:
          jobs:
            FOO: foo
            BAR: bar
      )
      it { should serialize_to env: { jobs: [{ FOO: 'foo', BAR: 'bar' }] } }
      it { should_not have_msg }
    end
  end

  describe 'given matrix (alias)' do
    describe 'as a string' do
      yaml %(
        env:
          matrix: FOO=foo
      )
      it { should serialize_to env: { jobs: [FOO: 'foo'] } }
      it { should have_msg [:info, :env, :alias_key, alias: 'matrix', key: 'jobs' ] }
    end

    describe 'as a seq of strings' do
      yaml %(
        env:
          matrix:
            - FOO=foo
            - BAR=bar
      )
      it { should serialize_to env: { jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
      it { should have_msg [:info, :env, :alias_key, alias: 'matrix', key: 'jobs' ] }
    end

    describe 'as a map' do
      yaml %(
        env:
          matrix:
            FOO: foo
            BAR: bar
      )
      it { should serialize_to env: { jobs: [{ FOO: 'foo', BAR: 'bar' }] } }
      it { should have_msg [:info, :env, :alias_key, alias: 'matrix', key: 'jobs' ] }
    end
  end

  describe 'given true', drop: true do
    yaml %(
      env: true
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :env, :invalid_type, expected: :map, actual: :bool, value: true] }
  end

  describe 'given a nested map', drop: true do
    yaml %(
      env:
        one:
          two: str
    )
    it { should serialize_to env: { jobs: [{ one: nil }] } }
    it { should have_msg [:error, :'env.jobs.one', :invalid_type, expected: :str, actual: :map, value: { two: 'str' }] }
  end

  describe 'given a seq of strings, with an empty cache' do # ??
    yaml %(
      cache:
      env: FOO=foo
    )
    it { should serialize_to env: { jobs: [FOO: 'foo'] } }
  end

  describe 'vim' do
    yaml %(
      env:
        - FOO=foo "BAR='bar'"
    )
    it { should serialize_to env: { jobs: [{ FOO: 'foo', BAR: "'bar'" }] } }
  end

  describe 'does not underscore keys (env)' do
    yaml %(
      env:
        - API=str
    )
    it { should serialize_to env: { jobs: [{ API: 'str' }] } }
  end

  describe 'misplaced key with secure' do
    yaml %(
      env:
        global:
        - FOO: str
        BAR:
          secure: str
    )
    it { should serialize_to env: { global: [FOO: 'str'], jobs: [BAR: { secure: 'str' }] } }
  end
end
