describe Travis::Yaml::Doc::Validate::UnknownKeys do
  let(:spec) { Travis::Yaml.expanded }
  let(:root) { Travis::Yaml.build(config) }

  subject { described_class.new(spec, root, {}) }
  before  { subject.apply }

  context 'unknown key' do
    let(:config) { { unknown: { foo: 'foo' } } }

    it { expect(root.serialize).to be_nil }
    it { expect(root.msgs).to include [:error, :root, :unknown_key, key: :unknown, value: { foo: 'foo' }] }
  end

  context 'silence error with underscore' do
    let(:config) { { _unknown: 'something' } }

    it { expect(root.serialize).to be_nil }
    it { expect(root.msgs).to be_empty }
  end
end
