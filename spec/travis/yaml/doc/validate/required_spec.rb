describe Travis::Yaml::Doc::Validate::Required do
  let(:root) { Travis::Yaml.build(lang: 'ruby') }
  let(:spec) { Travis::Yaml::Doc::Spec::Node.new(root, required: true) }
  let(:node) { build(root, :key, nil) }

  subject { described_class.new(spec, node, {}) }
  before  { subject.apply }

  it { expect(node.value).to be_nil }
  it { expect(root.msgs).to include [:error, :root, :required, key: :key] }
end
