describe Travis::Yaml::Doc::Validate::Alert do
  let(:spec) { Travis::Yaml::Doc::Spec::Scalar.new(nil, secure: true) }
  let(:node) { Travis::Yaml::Doc::Value::Scalar.new(nil, :key, 'value', alert: true) }

  subject { described_class.new(spec, node, {}) }

  before { subject.apply }

  it { expect(node.value).to be_nil }
  it { expect(node.msgs).to include [:error, :key, :alert] }
end
