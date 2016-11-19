describe Travis::Yaml::Doc::Conform::Flagged do
  let(:root) { Travis::Yaml.build({}) }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, 'value', opts) }
  let(:opts) { { flagged: true } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to eq 'value' }
    it { expect(root.msgs).to include [:info, :key, :flagged, 'your repository must be feature flagged for :key to be used'] }
  end
end
