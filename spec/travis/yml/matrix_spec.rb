describe Travis::Yml, 'matrix' do
  let(:matrix) { described_class.matrix(config) }
  let(:axes)   { matrix.axes }

  describe 'no matrix' do
    let(:config) { {} }

    let(:rows) do
      [{}]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (1)' do
    let(:config) do
      {
        rvm: ['2.2'],
        gemfile: ['a']
      }
    end

    let(:rows) do
      [
        { rvm: '2.2', gemfile: 'a' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (1 from include, redundant expand key at root)' do
    let(:config) do
      {
        os: 'linux',
        matrix: {
          include: [
            { os: 'osx', env: 'foo' }
          ]
        }
      }
    end

    let(:rows) do
      [
        { os: 'osx', env: ['foo'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (1 from include, multi-value expand key at root)' do
    let(:config) do
      {
        os: ['linux', 'osx'],
        matrix: {
          include: [
            { env: 'foo' }
          ]
        }
      }
    end

    let(:rows) do
      [
        { os: 'linux' },
        { os: 'osx' },
        { os: 'linux', env: ['foo'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (1 with non-expand key at root)' do
    let(:config) do
      {
        language: 'rust',
        matrix: {
          include: [
            { env: 'foo' }
          ]
        }
      }
    end

    let(:rows) do
      [
        { language: 'rust', env: ['foo'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (2)' do
    let(:config) do
      {
        rvm: ['2.2', '2.3'],
        gemfile: ['a']
      }
    end

    let(:rows) do
      [
        { rvm: '2.2', gemfile: 'a' },
        { rvm: '2.3', gemfile: 'a' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (3)' do
    let(:config) do
      {
        env: { matrix: ['foo', 'bar', 'baz'] },
        rvm: ['2.2', '2.3'],
        gemfile: ['a']
      }
    end

    let(:rows) do
      [
        { env: ['foo'], rvm: '2.2', gemfile: 'a' },
        { env: ['foo'], rvm: '2.3', gemfile: 'a' },
        { env: ['bar'], rvm: '2.2', gemfile: 'a' },
        { env: ['bar'], rvm: '2.3', gemfile: 'a' },
        { env: ['baz'], rvm: '2.2', gemfile: 'a' },
        { env: ['baz'], rvm: '2.3', gemfile: 'a' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'just env' do
    let(:config) do
      {
        env: { matrix: [{ FOO: 'foo' }, { BAR: 'bar' }] },
      }
    end

    let(:rows) do
      [
        { env: [FOO: 'foo'] },
        { env: [BAR: 'bar'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'with global env' do
    let(:config) do
      {
        env:  { matrix: ['foo', 'bar'], global: ['baz'] },
        rvm: ['2.2', '2.3'],
      }
    end

    let(:rows) do
      [
        { env: ['foo', 'baz'], rvm: '2.2' },
        { env: ['foo', 'baz'], rvm: '2.3' },
        { env: ['bar', 'baz'], rvm: '2.2' },
        { env: ['bar', 'baz'], rvm: '2.3' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'with env array' do
    let(:config) do
      {
        env: ['FOO=1', 'FOO=2']
      }
    end

    let(:rows) do
      [
        { env: ['FOO=1'] },
        { env: ['FOO=2'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'duplicate jobs' do
    let(:config) do
      {
        os: ['linux', 'osx'],
        osx_image: ['xcode9.4', 'xcode10.2']
      }
    end

    let(:rows) do
      [
        { os: 'linux' },
        { os: 'osx', osx_image: 'xcode9.4' },
        { os: 'osx', osx_image: 'xcode10.2' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix include' do
    let(:config) do
      {
        env: { matrix: ['foo'] },
        rvm: ['2.2', '2.3'],
        matrix: { include: [{ env: 'bar', rvm: '2.4' }] },
      }
    end

    let(:rows) do
      [
        { env: ['foo'], rvm: '2.2' },
        { env: ['foo'], rvm: '2.3' },
        { env: ['bar'], rvm: '2.4' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix include duplicate' do
    let(:config) do
      {
        env: { matrix: ['foo'] },
        rvm: ['2.2'],
        matrix: { include: [{ env: 'foo', rvm: '2.2' }] },
      }
    end

    let(:rows) do
      [
        { env: ['foo'], rvm: '2.2' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix exclude (1)' do
    let(:config) do
      {
        env: { matrix: ['foo', 'bar'] },
        rvm: ['2.2', '2.3'],
        matrix: { exclude: [{ env: 'bar', rvm: '2.3' }] },
      }
    end

    let(:rows) do
      [
        { env: ['foo'], rvm: '2.2' },
        { env: ['foo'], rvm: '2.3' },
        { env: ['bar'], rvm: '2.2' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix exclude (2)' do
    let(:config) do
      {
        scala: ['2.11.8'],
        jdk: 'oraclejdk8',
        matrix: { exclude: [{ scala: '2.11.8', jdk: 'oraclejdk8' }] },
      }
    end

    it { expect(matrix.rows).to eq [] }
  end

  describe 'null env with include' do
    let(:config) do
      {
        env: nil,
        matrix: { include: [{ rvm: '1.8.7', env: 'foo=bar' }] },
        rvm: ['2.2', '2.3']
      }
    end

    let(:rows) do
      [
        { rvm: '2.2' },
        { rvm: '2.3' },
        { rvm: '1.8.7', env: ['foo=bar'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'include as hash' do
    let(:config) do
      {
        dist: 'trusty',
        matrix: { include: { env: ['distribution=debian'] } }
      }
    end

    let(:rows) do
      [
        { dist: 'trusty', env: ['distribution=debian'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'removes version' do
    let(:config) do
      { version: '= 0', language: 'shell' }
    end

    let(:rows) do
      [
        { language: 'shell' }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end
end
