describe Travis::Yaml, 'git' do
  let(:msgs) { subject.msgs }
  let(:git)  { subject.to_h[:git] }

  subject { described_class.apply(config) }

  describe 'depth' do
    let(:config) { { git: { depth: '42' } } }
    it { expect(git[:depth]).to eq '42' }
  end

  describe 'submodules' do
    let(:config) { { git: { submodules: false } } }
    it { expect(git[:submodules]).to eq false }

    describe 'cast from string' do
      let(:config) { { git: { submodules: 'false' } } }
      it { expect(git[:submodules]).to eq false }
      # it { expect(msgs).to include([:warn, :'git.submodules', :cast, 'casting value "false" to false (:bool)']) }
    end
  end

  describe 'strategy' do
    describe 'can be :clone' do
      let(:config) { { git: { strategy: 'clone' } } }
      it { expect(git[:strategy]).to be == 'clone' }
    end

    describe 'can be tarball' do
      let(:config) { { git: { strategy: 'tarball' } } }
      it { expect(git[:strategy]).to be == 'tarball' }
    end

    describe 'cannot be foo' do
      let(:config) { { git: { strategy: 'foo' } } }
      it { expect(msgs).to include [:error, :'git.strategy', :unknown_value, 'dropping unknown value "foo"'] }
      it { expect(msgs).to include [:error, :root, :empty, 'dropping empty section :git'] }
    end
  end
end
