describe Travis::Yaml, 'env' do
  let(:msgs) { subject.msgs }
  let(:env)  { subject.to_h[:env] }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { env: 'FOO=foo' } }
    it { expect(env[:matrix]).to eq ['FOO=foo'] }
  end

  describe 'given an array of strings' do
    let(:config) { { env: ['FOO=foo', 'BAR=bar'] } }
    it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
  end

  describe 'given a hash' do
    let(:config) { { env: { FOO: 'foo', BAR: 'bar' } } }
    it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
  end

  describe 'given a single secure string' do
    let(:config) { { env: { secure: 'secure' } } }
    it { expect(env[:matrix]).to eq [{ secure: 'secure' }] }
  end

  describe 'given an array of secure strings' do
    let(:config) { { env: [{ secure: 'secure' }] } }
    it { expect(env[:matrix]).to eq [{ secure: 'secure' }] }
  end

  describe 'given an array of hashes' do
    let(:config) { { env: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
  end

  describe 'given global' do
    describe 'as a string' do
      let(:config) { { env: { global: 'FOO=foo' } } }
      it { expect(env[:global]).to eq ['FOO=foo'] }
    end

    describe 'an array of strings' do
      let(:config) { { env: { global: ['FOO=foo', 'BAR=bar'] } } }
      it { expect(env[:global]).to eq ['FOO=foo', 'BAR=bar'] }
    end

    describe 'as a hash' do
      let(:config) { { env: { global: { FOO: 'foo', BAR: 'bar' } } } }
      it { expect(env[:global]).to eq ['FOO=foo', 'BAR=bar'] }
    end

    describe 'given an array of hashes' do
      let(:config) { { env: { global: [{ FOO: 'foo' }, { BAR: 'bar' }] } } }
      it { expect(env[:global]).to eq ['FOO=foo', 'BAR=bar'] }
    end
  end

  describe 'given matrix' do
    describe 'as a string' do
      let(:config) { { env: { matrix: 'FOO=foo' } } }
      it { expect(env[:matrix]).to eq ['FOO=foo'] }
    end

    describe 'as an array of strings' do
      let(:config) { { env: { matrix: ['FOO=foo', 'BAR=bar'] } } }
      it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
    end

    describe 'as a hash' do
      let(:config) { { env: { matrix: { FOO: 'foo', BAR: 'bar' } } } }
      it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
    end
  end
end
