describe Travis::Yaml, 'env' do
  let(:env)  { subject.serialize[:env] }

  subject { described_class.apply(input) }

  describe 'given a string' do
    let(:input) { { env: 'FOO=foo' } }
    it { expect(env[:matrix]).to eq ['FOO=foo'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of strings' do
    let(:input) { { env: ['FOO=foo', 'BAR=bar'] } }
    it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array with nil' do
    let(:input) { { env: [nil] } }
    it { expect(env).to be_nil }
    it { expect(msgs).to include [:warn, :root, :empty, key: :env] }
  end

  describe 'given a hash' do
    let(:input) { { env: { FOO: 'foo', BAR: 'bar' } } }
    it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given a single secure string' do
    let(:input) { { env: { secure: 'secure' } } }
    it { expect(env[:matrix]).to eq [{ secure: 'secure' }] }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of secure strings' do
    let(:input) { { env: [{ secure: 'secure' }] } }
    it { expect(env[:matrix]).to eq [{ secure: 'secure' }] }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of hashes' do
    let(:input) { { env: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
    it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given a misplaced key' do
    let(:input) { { env: { DEBUG: 'true' } } }
    it { expect(env[:matrix]).to eq ['DEBUG=true'] }
    it { expect(msgs).to be_empty }
  end

  # describe 'given a hash mixing known, unknown, and misplaced keys' do
  #   let(:input) { { env: { FOO: 'foo', matrix: { BAR: 'bar' }, before_script: 'foo' } } }
  #   it { expect(env[:matrix]).to eq ['FOO=foo', 'before_script=foo', 'BAR=bar'] }
  #   it { expect(env[:general]).to be nil }
  #   it { expect(msgs).to include [:warn, :env, :migrate_keys, keys: [:FOO, :before_script], to: :matrix] }
  # end
  #
  # describe 'given a hash mixing known and unknown keys holding arrays' do
  #   let(:input) { { env: { general: ['FOO=foo'], matrix: ['BAR=bar'] } } }
  #   it { expect(env[:matrix]).to eq ['BAR=bar', 'FOO=foo'] }
  #   it { expect(msgs).to include [:warn, :env, :migrate_keys, keys: [:general], to: :matrix] }
  # end

  describe 'given global' do
    describe 'as a string' do
      let(:input) { { env: { global: 'FOO=foo' } } }
      it { expect(env[:global]).to eq ['FOO=foo'] }
      it { expect(msgs).to be_empty }
    end

    describe 'an array of strings' do
      let(:input) { { env: { global: ['FOO=foo', 'BAR=bar'] } } }
      it { expect(env[:global]).to eq ['FOO=foo', 'BAR=bar'] }
      it { expect(msgs).to be_empty }
    end

    describe 'as a hash' do
      let(:input) { { env: { global: { FOO: 'foo', BAR: 'bar' } } } }
      it { expect(env[:global]).to eq ['FOO=foo', 'BAR=bar'] }
      it { expect(msgs).to be_empty }
    end

    describe 'given an array with a hash' do
      let(:input) { { env: { global: [{ FOO: 'foo' }] } } }
      it { expect(env[:global]).to eq ['FOO=foo'] }
      it { expect(msgs).to be_empty }
    end

    describe 'given an array of hashes' do
      let(:input) { { env: { global: [{ FOO: 'foo' }, { BAR: 'bar' }] } } }
      it { expect(env[:global]).to eq ['FOO=foo', 'BAR=bar'] }
      it { expect(msgs).to be_empty }
    end

    describe 'given a misplaced secure on the parent' do
      let(:input) { { env: { global: [{ secure: 'secure' }] }, global: { secure: 'secure' } } }
      it { expect(env).to eq global: [{ secure: 'secure' }] }
      it { expect(msgs).to include [:warn, :root, :migrate, key: :global, to: :env, value: { secure: 'secure' }] }
    end
  end

  describe 'given matrix' do
    describe 'as a string' do
      let(:input) { { env: { matrix: 'FOO=foo' } } }
      it { expect(env[:matrix]).to eq ['FOO=foo'] }
      it { expect(msgs).to be_empty }
    end

    describe 'as an array of strings' do
      let(:input) { { env: { matrix: ['FOO=foo', 'BAR=bar'] } } }
      it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
      it { expect(msgs).to be_empty }
    end

    describe 'as a hash' do
      let(:input) { { env: { matrix: { FOO: 'foo', BAR: 'bar' } } } }
      it { expect(env[:matrix]).to eq ['FOO=foo', 'BAR=bar'] }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'given an array of strings, with an empty cache' do
    let(:input) { { cache: nil, env: ['FOO=foo'] } }
    it { expect(env[:matrix]).to eq ['FOO=foo'] }
  end
end
