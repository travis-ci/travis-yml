describe Travis::Yaml, 'matrix' do
  # Testing only what the Matrix class does,
  # without relying on the parsing step
  let(:matrix) { described_class.matrix(input) }
  let(:axes)   { matrix.axes }

  describe 'no matrix' do
    let(:input) { {} }

    let(:rows) do
      [{}]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'matrix (1)' do
    let(:input) do
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

  describe 'matrix (2)' do
    let(:input) do
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
    let(:input) do
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
    let(:input) do
      {
        env:  { matrix: ['foo', 'bar'] },
      }
    end

    let(:rows) do
      [
        { env: ['foo'] },
        { env: ['bar'] }
      ]
    end

    it { expect(matrix.rows).to eq rows }
  end

  describe 'with global env' do
    let(:input) do
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
    let(:input) do
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

  describe 'matrix include' do
    let(:input) do
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
    let(:input) do
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
    let(:input) do
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
    let(:input) do
      {
        scala: ['2.11.8'],
        jdk: 'oraclejdk8',
        matrix: { exclude: [{ scala: '2.11.8', jdk: 'oraclejdk8' }] },
      }
    end

    it { expect(matrix.rows).to eq [] }
  end

  describe 'null env with include' do
    let(:input) do
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
end
