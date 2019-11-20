describe Travis::Yml, 'matrix' do
  def self.expands_to(rows)
    it { should eq rows }
  end

  let(:config) { described_class.apply(parse(yaml)).serialize }
  let(:matrix) { described_class.matrix(config) }

  subject { matrix.rows }

  describe 'no matrix' do
    yaml ''
    expands_to [{}]
  end

  describe 'matrix (1)' do
    yaml %(
      rvm: 2.2
      gemfile: str
    )

    expands_to [
      { rvm: '2.2', gemfile: 'str' }
    ]
  end

  describe 'matrix (1 from include, redundant expand key at root)' do
    yaml %(
      os: linux
      jobs:
        include:
          - os: osx
            env: FOO=foo
    )

    expands_to [
      { os: 'osx', env: [FOO: 'foo'] }
    ]
  end

  describe 'matrix (1 from include, multi-value expand key at root)' do
    yaml %(
      os:
      - linux
      - osx
      jobs:
        include:
          - env: FOO=foo
    )

    expands_to [
      { os: 'linux' },
      { os: 'osx' },
      { os: 'linux', env: [FOO: 'foo'] }
    ]
  end

  describe 'matrix (1 with non-expand key at root)' do
    yaml %(
    language: rust
    jobs:
      include:
        env: FOO=foo
    )

    expands_to [
      { language: 'rust', env: [FOO: 'foo'] }
    ]
  end

  describe 'matrix (2)' do
    yaml %(
      rvm:
      - 2.2
      - 2.3
      gemfile:
      - str
    )

    expands_to [
      { rvm: '2.2', gemfile: 'str' },
      { rvm: '2.3', gemfile: 'str' }
    ]
  end

  describe 'matrix (3)' do
    yaml %(
      env:
        jobs:
        - FOO=foo
        - BAR=bar
        - BAZ=baz
      rvm:
      - 2.2
      - 2.3
      gemfile:
      - str
    )

    expands_to [
      { env: [FOO: 'foo'], rvm: '2.2', gemfile: 'str' },
      { env: [FOO: 'foo'], rvm: '2.3', gemfile: 'str' },
      { env: [BAR: 'bar'], rvm: '2.2', gemfile: 'str' },
      { env: [BAR: 'bar'], rvm: '2.3', gemfile: 'str' },
      { env: [BAZ: 'baz'], rvm: '2.2', gemfile: 'str' },
      { env: [BAZ: 'baz'], rvm: '2.3', gemfile: 'str' }
    ]
  end

  describe 'env.jobs strs' do
    yaml %(
      env:
        jobs:
        - FOO=foo BAR=bar
        - BAZ=baz
    )

    expands_to [
      { env: [FOO: 'foo', BAR: 'bar'] },
      { env: [BAZ: 'baz'] }
    ]
  end

  describe 'env.jobs hashes' do
    yaml %(
      env:
        jobs:
        - FOO: foo
        - BAR: bar
    )

    expands_to [
      { env: [FOO: 'foo'] },
      { env: [BAR: 'bar'] }
    ]
  end

  describe 'env.jobs one hash' do
    yaml %(
      env:
        jobs:
          FOO: foo
          BAR: bar
    )

    expands_to [
      { env: [FOO: 'foo', BAR: 'bar'] },
    ]
  end

  describe 'env.jobs and env.global' do
    yaml %(
      env:
        jobs:
          - FOO: foo
          - BAR: bar
        global:
          - BAZ: baz
      rvm:
      - 2.2
      - 2.3
    )

    expands_to [
      { env: [{ FOO: 'foo' }, { BAZ: 'baz' }], rvm: '2.2' },
      { env: [{ FOO: 'foo' }, { BAZ: 'baz' }], rvm: '2.3' },
      { env: [{ BAR: 'bar' }, { BAZ: 'baz' }], rvm: '2.2' },
      { env: [{ BAR: 'bar' }, { BAZ: 'baz' }], rvm: '2.3' }
    ]
  end

  describe 'env strs' do
    yaml %(
    env:
      - FOO=1
      - FOO=2
    )

    expands_to [
      { env: [FOO: '1'] },
      { env: [FOO: '2'] }
    ]
  end

  describe 'duplicate jobs' do
    yaml %(
      os:
      - linux
      - osx
      osx_image:
      - xcode9.4
      - xcode10.2
    )

    expands_to [
      { os: 'linux' },
      { os: 'osx', osx_image: 'xcode9.4' },
      { os: 'osx', osx_image: 'xcode10.2' }
    ]
  end

  describe 'env and jobs include' do
    yaml %(
      env: FOO=foo
      jobs:
        include:
          - name: one
          - name: two
    )

    expands_to [
      { env: [FOO: 'foo'], name: 'one' },
      { env: [FOO: 'foo'], name: 'two' },
    ]
  end

  describe 'rvm and jobs include' do
    yaml %(
      rvm: 2.5
      jobs:
        include:
          - name: one
          - name: two
    )

    expands_to [
      { rvm: '2.5', name: 'one' },
      { rvm: '2.5', name: 'two' },
    ]
  end

  describe 'jobs include (1)' do
    yaml %(
      env:
        jobs: FOO=foo
      rvm:
      - 2.2
      - 2.3
      jobs:
        include:
          - env: BAR=bar
            rvm: 2.4
    )

    expands_to [
      { env: [FOO: 'foo'], rvm: '2.2' },
      { env: [FOO: 'foo'], rvm: '2.3' },
      { env: [BAR: 'bar'], rvm: '2.4' }
    ]
  end

  describe 'jobs include (2)' do
    yaml %(
      env:
        global:
          FOO: foo
      jobs:
        include:
          - name: one
          - name: two
    )

    expands_to [
      { env: [FOO: 'foo'], name: 'one' },
      { env: [FOO: 'foo'], name: 'two' },
    ]
  end

  describe 'jobs include inheriting a global matrix key' do
    yaml %(
      rvm: 2.4
      jobs:
        include:
          - rvm: 2.2
          - name: str
    )

    expands_to [
      { rvm: '2.2' },
      { rvm: '2.4', name: 'str' }
    ]
  end

  describe 'jobs include inheriting env' do
    yaml %(
      env: FOO=foo
      jobs:
        include:
          - name: one
          - name: two
    )

    expands_to [
      { env: [FOO: 'foo'], name: 'one' },
      { env: [FOO: 'foo'], name: 'two' }
    ]
  end

  describe 'jobs include inheriting env' do
    yaml %(
      env:
        global: FOO=foo
      jobs:
        include:
          - name: one
          - name: two
    )

    expands_to [
      { env: [FOO: 'foo'], name: 'one' },
      { env: [FOO: 'foo'], name: 'two' }
    ]
  end

  describe 'jobs include duplicate' do
    yaml %(
      env:
        jobs: FOO=foo
      rvm:
      - 2.2
      jobs:
        include:
          - env: FOO=foo
            rvm: 2.2
    )

    expands_to [
      { env: [FOO: 'foo'], rvm: '2.2' }
    ]
  end

  describe 'jobs exclude (1)' do
    yaml %(
      env:
        jobs:
        - FOO=foo
        - BAR=bar
      rvm:
      - 2.2
      - 2.3
      jobs:
        exclude:
          - env: BAR=bar
            rvm: 2.3
    )

    expands_to [
      { env: [FOO: 'foo'], rvm: '2.2' },
      { env: [FOO: 'foo'], rvm: '2.3' },
      { env: [BAR: 'bar'], rvm: '2.2' }
    ]
  end

  describe 'jobs exclude (2)' do
    yaml %(
      scala: 2.11.8
      jdk: oraclejdk8
      jobs:
        exclude:
        - scala: 2.11.8
          jdk: oraclejdk8
    )

    expands_to []
  end

  describe 'jobs exclude (3)' do
    yaml %(
      env:
        - FOO=one BAR=one
        - FOO=two BAR=two
      jobs:
        exclude:
          - env: FOO=one BAR=one
    )

    expands_to [env: [FOO: 'two', BAR: 'two']]
  end

  describe 'conditional jobs exclude (1)' do
    yaml %(
      env:
        - FOO=one BAR=one
        - FOO=two BAR=two
      jobs:
        exclude:
          - env: FOO=one BAR=one
            if: branch = master
    )

    expands_to [env: [FOO: 'two', BAR: 'two']]
  end

  describe 'null env with include' do
    yaml %(
      env:
      rvm:
      - 2.2
      - 2.3
      jobs:
        include:
        - rvm: 1.8.7
          env: FOO=foo
    )

    expands_to [
      { rvm: '2.2' },
      { rvm: '2.3' },
      { rvm: '1.8.7', env: [FOO: 'foo'] }
    ]
  end

  describe 'include as hash' do
    yaml %(
      dist: trusty
      jobs:
        include:
          env: FOO=foo
    )

    expands_to [
      { dist: 'trusty', env: [FOO: 'foo'] }
    ]
  end

  describe 'removes version' do
    yaml %(
      language: shell
      version: '= 0'
    )

    expands_to [
      { language: 'shell' }
    ]
  end
end
