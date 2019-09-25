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
      matrix:
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
      matrix:
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
    matrix:
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
        matrix:
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

  describe 'env.matrix strs' do
    yaml %(
      env:
        matrix:
        - FOO=foo BAR=bar
        - BAZ=baz
    )

    expands_to [
      { env: [FOO: 'foo', BAR: 'bar'] },
      { env: [BAZ: 'baz'] }
    ]
  end

  describe 'env.matrix hashes' do
    yaml %(
      env:
        matrix:
        - FOO: foo
        - BAR: bar
    )

    expands_to [
      { env: [FOO: 'foo'] },
      { env: [BAR: 'bar'] }
    ]
  end

  describe 'env.matrix one hash' do
    yaml %(
      env:
        matrix:
          FOO: foo
          BAR: bar
    )

    expands_to [
      { env: [FOO: 'foo', BAR: 'bar'] },
    ]
  end

  describe 'env.matrix and env.global' do
    yaml %(
      env:
        matrix:
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

  describe 'matrix include' do
    yaml %(
      env:
        matrix: FOO=foo
      rvm:
      - 2.2
      - 2.3
      matrix:
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

  describe 'matrix include duplicate' do
    yaml %(
      env:
        matrix: FOO=foo
      rvm:
      - 2.2
      matrix:
        include:
          - env: FOO=foo
            rvm: 2.2
    )

    expands_to [
      { env: [FOO: 'foo'], rvm: '2.2' }
    ]
  end

  describe 'matrix exclude (1)' do
    yaml %(
      env:
        matrix:
        - FOO=foo
        - BAR=bar
      rvm:
      - 2.2
      - 2.3
      matrix:
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

  describe 'matrix exclude (2)' do
    yaml %(
      scala: 2.11.8
      jdk: oraclejdk8
      matrix:
        exclude:
        - scala: 2.11.8
          jdk: oraclejdk8
    )

    expands_to []
  end

  describe 'null env with include' do
    yaml %(
      env:
      rvm:
      - 2.2
      - 2.3
      matrix:
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
      matrix:
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
