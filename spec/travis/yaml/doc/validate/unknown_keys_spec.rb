describe Travis::Yaml::Doc::Validate::UnknownKeys do
  let(:spec) { Travis::Yaml.expanded }
  let(:root) { Travis::Yaml.build(unknown: { foo: 'foo' }) }

  subject { described_class.new(spec, root, {}) }
  before  { subject.apply }

  it { expect(root.serialize).to be_nil }
  it { expect(root.msgs).to include [:error, :root, :unknown_key, key: :unknown, value: { foo: 'foo' }] }
end
