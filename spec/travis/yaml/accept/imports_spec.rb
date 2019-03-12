describe Travis::Yaml, 'imports' do
  let(:imports) { subject.serialize[:import] }
  let(:source)  { 'travis-ci/build-configs/ruby.yml@v1' }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { import: source } }
    it { expect(imports).to eq [source: source] }
  end

  describe 'given an array of strings' do
    let(:config) { { import: [source] } }
    it { expect(imports).to eq [source: source] }
  end

  describe 'given an array of hashes' do
    let(:config) { { import: [source: source, mode: 'merge'] } }
    it { expect(imports).to eq [source: source, mode: 'merge'] }
  end

  describe 'given an array of hashes (alias merge_mode)' do
    let(:config) { { import: [source: source, merge_mode: 'merge'] } }
    it { expect(imports).to eq [source: source, mode: 'merge'] }
    it { expect(info).to include [:info, :import, :alias, alias: :merge_mode, actual: :mode] }
  end
end
