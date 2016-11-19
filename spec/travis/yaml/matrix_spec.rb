describe Travis::Yaml, 'matrix' do
  let(:config) { described_class.apply(input).to_h }
  let(:matrix) { described_class.matrix(config) }
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
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', ruby: '2.2', gemfile: 'a' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
    it { expect(matrix.axes).to eq [:os, :ruby, :gemfile] }
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
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', ruby: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', ruby: '2.3', gemfile: 'a' },
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
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.3', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar'], ruby: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar'], ruby: '2.3', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['baz'], ruby: '2.2', gemfile: 'a' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['baz'], ruby: '2.3', gemfile: 'a' },
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
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo', 'baz'], ruby: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo', 'baz'], ruby: '2.3' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar', 'baz'], ruby: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar', 'baz'], ruby: '2.3' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix include' do
    let(:input) do
      {
        env:    { matrix: ['foo'] },
        ruby:   ['2.2', '2.3'],
        matrix: { include: [{ env: 'bar', ruby: '2.4' }] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.3' },
        { language: 'ruby', dist: 'precise', sudo: false, env: ['bar'], ruby: '2.4' },
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
        matrix: { include: [{ env: 'foo', ruby: '2.2' }] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.2' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix exclude' do
    let(:input) do
      {
        env:    { matrix: ['foo', 'bar'] },
        ruby:   ['2.2', '2.3'],
        matrix: { exclude: [{ env: 'bar', ruby: '2.3' }] },
      }
    end

    let(:rows) do
      [
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.2' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['foo'], ruby: '2.3' },
        { language: 'ruby', dist: 'precise', sudo: false, os: 'linux', env: ['bar'], ruby: '2.2' },
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end
end
