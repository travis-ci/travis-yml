describe Travis::Yaml::Doc::Type::Scalar do
  let(:root)  { Travis::Yaml.build(lang: 'ruby') }
  let(:lang)  { root.children[0] }
  let(:node)  { described_class.new(root, :key, 'value', opts) }
  let(:opts)  { { cast: [:secure] } }

  describe 'types' do
    it { expect(lang.types).to eq [:str] }
    it { expect(node.types).to eq [:secure] }
  end

  describe 'secure?' do
    it { expect(lang).to_not be_secure }
    it { expect(node).to     be_secure }
  end

  describe 'downcase?' do
    it { expect(lang).to     be_downcase }
    it { expect(node).to_not be_downcase }
  end

  describe 'error' do
    before { node.error :alert }
    it { expect(root.msgs).to_not be_empty }
    it { expect(node.value).to    be_nil }
  end
end
