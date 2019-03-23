describe Travis::Yaml::Doc::Validate::UnknownValue do
  let(:spec)  { Travis::Yaml::Doc::Spec::Fixed.new(nil, values: [value: 'foo']) }
  let(:node)  { build(nil, :key, value) }

  subject { described_class.new(spec, node, {}) }
  before  { subject.apply }

  describe 'given an known value' do
    let(:value) { 'foo' }

    it { expect(node.value).to eq 'foo' }
    it { expect(node.msgs).to be_empty }
  end

  describe 'given an unknown value' do
    let(:value) { 'bar' }

    it { expect(node.value).to be_nil }
    it { expect(node.msgs).to include [:error, :key, :unknown_value, value: 'bar'] }
  end
end

