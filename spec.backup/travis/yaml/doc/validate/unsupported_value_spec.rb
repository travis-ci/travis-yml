describe Travis::Yaml::Doc::Validate::UnsupportedValue do
  let(:root) { Travis::Yaml.build(language: 'ruby') }
  let(:spec) { Travis::Yaml::Doc::Spec::Fixed.new(nil, opts) }
  let(:opts) { { values: [value: 'value', except: { language: 'ruby' }] } }
  let(:node) { build(root, :key, 'value') }

  subject { described_class.new(spec, node, {}) }
  before  { subject.apply }

  it { expect(node.value).to be nil }
  it { expect(root.msgs).to include [:error, :key, :unsupported, on_key: :language, on_value: 'ruby', key: :key, value: 'value'] }
end
