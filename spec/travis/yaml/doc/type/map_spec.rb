describe Travis::Yaml::Doc::Type::Map do
  let(:root)  { Travis::Yaml.build(lang: 'ruby') }
  let(:lang)  { root.children[0] }
  let(:dist)  { root.children[2] }
  let(:node)  { described_class.new(root, :key, value, opts) }
  let(:value) { { foo: 'foo' } }
  let(:opts)  { { strict: false } }

  describe 'strict?' do
    it { expect(root).to     be_strict }
    it { expect(node).to_not be_strict }
  end

  describe 'present?' do
    it { expect(root).to     be_present }
    it { expect(node).to_not be_present }
  end

  describe 'error' do
    before { node.error :alert }
    it { expect(root.msgs).to_not be_empty }
    it { expect(node.present?).to be false }
  end
end
