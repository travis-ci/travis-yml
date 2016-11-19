describe Travis::Yaml::Doc::Conform::Required do
  let(:root) { Travis::Yaml.build(lang: 'ruby') }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, nil, opts) }
  let(:opts) { { required: true } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to be_nil }
    it { expect(root.msgs).to include [:error, :root, :required, 'missing required key :key'] }
  end
end
