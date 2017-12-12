describe Travis::Yaml, 'matrix' do
  let(:config) { described_class.apply(input) }
  let(:matrix) { described_class.matrix(config.serialize) }
  let(:axes)   { matrix.axes }

  describe 'no matrix' do
    let(:input) { {} }

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (1)' do
    let(:input) do
      {
        ruby:    ['2.2'],
        gemfile: ['a']
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', rvm: '2.2', gemfile: 'a' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
    it { expect(matrix.axes).to eq [:os, :gemfile, :rvm] }
  end

  describe 'matrix (2)' do
    let(:input) do
      {
        ruby:    ['2.2', '2.3'],
        gemfile: ['a']
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', rvm: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', rvm: '2.3', gemfile: 'a' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (3)' do
    let(:input) do
      {
        env:     { matrix: ['foo', 'bar', 'baz'] },
        ruby:    ['2.2', '2.3'],
        gemfile: ['a']
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], rvm: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], rvm: '2.3', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar'], rvm: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar'], rvm: '2.3', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['baz'], rvm: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['baz'], rvm: '2.3', gemfile: 'a' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'just env' do
    let(:input) do
      {
        env:  { matrix: ['foo', 'bar'] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'] },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar'] },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'with global env' do
    let(:input) do
      {
        env:  { matrix: ['foo', 'bar'], global: ['baz'] },
        ruby: ['2.2', '2.3'],
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo', 'baz'], rvm: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo', 'baz'], rvm: '2.3' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar', 'baz'], rvm: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar', 'baz'], rvm: '2.3' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'with env array' do
    let(:input) do
      {
        env: ['FOO=1', 'FOO=2']
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['FOO=1'] },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['FOO=2'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix include' do
    let(:input) do
      {
        env:    { matrix: ['foo'] },
        ruby:   ['2.2', '2.3'],
        matrix: { include: [{ env: 'bar', rvm: '2.4' }] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], rvm: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], rvm: '2.3' },
        { language: 'ruby', dist: 'precise', sudo: false, env: ['bar'], rvm: '2.4' },
      ]
    end

    # TODO does not include the os to the matrix include
    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix include duplicate' do
    let(:input) do
      {
        env:    { matrix: ['foo'] },
        ruby:   ['2.2'],
        matrix: { include: [{ env: 'foo', rvm: '2.2' }] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], rvm: '2.2' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix exclude (1)' do
    let(:input) do
      {
        env:    { matrix: ['foo', 'bar'] },
        ruby:   ['2.2', '2.3'],
        matrix: { exclude: [{ env: 'bar', rvm: '2.3' }] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', rvm: '2.2', env: ['foo'] },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', rvm: '2.3', env: ['foo'] },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', rvm: '2.2', env: ['bar'] },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix exclude (2)' do
    let(:input) do
      {
        scala: ['2.11.8'],
        jdk: 'oraclejdk8',
        matrix: { exclude: [{ scala: '2.11.8', jdk: 'oraclejdk8' }] },
      }
    end

    it { expect(matrix.rows).to eq [] }
  end
end
