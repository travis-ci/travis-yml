describe Travis::Yaml::Doc::Validate::Empty do
  let(:root) { Travis::Yaml.build(language: 'ruby') }

  subject { described_class.new(spec, node, {}) }
  before  { subject.apply }

  describe 'given a map' do
    let(:spec) { Travis::Yaml::Doc::Spec::Map.new(nil, { type: :map }) }
    let(:node) { build(root, :key, {}) }

    it { expect(node.present?).to be false }
    it { expect(root.msgs).to include [:warn, :root, :empty, key: :key] }
  end

  describe 'given a seq' do
    let(:spec) { Travis::Yaml::Doc::Spec::Map.new(nil, { type: :seq }) }
    let(:node) { build(root, :key, []) }

    it { expect(node.present?).to be false }
    it { expect(root.msgs).to include [:warn, :root, :empty, key: :key] }
  end
end
