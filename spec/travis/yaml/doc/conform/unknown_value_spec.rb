describe Travis::Yaml::Doc::Conform::UnknownValue do
  let(:root) { Travis::Yaml.build({}) }
  let(:node) { Travis::Yaml::Doc::Type::Fixed.new(root, :key, 'foo', opts) }
  let(:opts) { { values: [value: 'bar'] } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply? }
    before { subject.apply }

    it { expect(node.value).to be nil }
    it { expect(root.msgs).to include [:error, :key, :unknown_value, 'dropping unknown value "foo"'] }
  end
end

