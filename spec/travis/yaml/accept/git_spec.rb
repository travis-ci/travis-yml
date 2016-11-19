describe Travis::Yaml, 'git' do
  let(:git)  { subject.serialize[:git] }

  subject { described_class.apply(config) }

  describe 'quiet' do
    let(:config) { { git: { quiet: true } } }
    it { expect(git[:quiet]).to eq true }
    it { expect(msgs).to be_empty }
  end

  describe 'depth' do
    let(:config) { { git: { depth: '42' } } }
    it { expect(git[:depth]).to eq '42' }
    it { expect(msgs).to be_empty }
  end

  describe 'submodules' do
    let(:config) { { git: { submodules: false } } }
    it { expect(git[:submodules]).to eq false }
    it { expect(msgs).to be_empty }

    describe 'cast from string' do
      let(:config) { { git: { submodules: 'false' } } }
      it { expect(git[:submodules]).to eq false }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'submodules_depth' do
    let(:config) { { git: { submodules_depth: 10 } } }
    it { expect(git[:submodules_depth]).to eq '10' }
    it { expect(msgs).to be_empty }
  end

  describe 'strategy' do
    describe 'can be :clone' do
      let(:config) { { git: { strategy: 'clone' } } }
      it { expect(git[:strategy]).to be == 'clone' }
      it { expect(msgs).to be_empty }
    end

    describe 'can be tarball' do
      let(:config) { { git: { strategy: 'tarball' } } }
      it { expect(git[:strategy]).to be == 'tarball' }
      it { expect(msgs).to be_empty }
    end

    describe 'cannot be foo' do
      let(:config) { { git: { strategy: 'foo' } } }
      it { expect(msgs).to include [:error, :'git.strategy', :unknown_value, value: 'foo'] }
      it { expect(msgs.size).to eq 1 }
    end
  end
end
