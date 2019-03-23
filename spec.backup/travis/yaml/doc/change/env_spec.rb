describe Travis::Yaml::Doc::Change::Env do
  subject { change(build(nil, :root, value, {})) }

  describe 'on root' do
    let(:env) { subject.raw[:env] }

    describe 'given a string' do
      let(:value) { { env: 'FOO=foo BAR=bar' } }
      it { expect(env).to eq matrix: ['FOO=foo BAR=bar'] }
    end

    describe 'given an array of strings' do
      let(:value) { { env: ['FOO=foo', 'BAR=bar'] } }
      it { expect(env).to eq matrix: ['FOO=foo', 'BAR=bar'] }
    end

    describe 'given a hash' do
      let(:value) { { env: { FOO: 'foo', BAR: 'bar' } } }
      it { expect(env).to eq matrix: ['FOO=foo', 'BAR=bar'] }
    end

    describe 'given an array of hashes' do
      let(:value) { { env: [{ FOO: 'foo' }, { BAR: 'bar' }] } }
      it { expect(env).to eq matrix: ['FOO=foo', 'BAR=bar'] }
    end
  end

  describe 'on matrix include' do
    let(:env) { subject.raw[:matrix][:include][0][:env] }

    describe 'given a string' do
      let(:value) { { matrix: { include: [env: 'FOO=foo'] } } }
      it { expect(env).to eq ['FOO=foo'] }
    end

    describe 'given an array of strings' do
      let(:value) { { matrix: { include: [env: ['FOO=foo']] } } }
      it { expect(env).to eq ['FOO=foo'] }
    end

    describe 'given a hash' do
      let(:value) { { matrix: { include: [env: { FOO: 'foo' }] } } }
      it { expect(env).to eq ['FOO=foo'] }
    end

    describe 'given an array of hashes' do
      let(:value) { { matrix: { include: [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } } }
      it { expect(env).to eq ['FOO=foo', 'BAR=bar'] }
    end
  end
end
