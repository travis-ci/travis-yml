describe Travis::Yaml::Doc::Conform::Edge do
  let(:root) { Travis::Yaml.build({}) }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, 'value', opts) }
  let(:opts) { { edge: true } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to eq 'value' }
    it { expect(root.msgs).to include [:info, :key, :edge, ':key is experimental and might be removed in the future'] }
  end
end
