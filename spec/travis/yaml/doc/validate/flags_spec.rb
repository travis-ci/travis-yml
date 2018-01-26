describe Travis::Yaml::Doc::Validate::Flags do
  let(:spec) { Travis::Yaml::Doc::Spec::Scalar.new(nil, opts) }
  let(:node) { build(nil, :key, 'value') }

  subject { described_class.new(spec, node, {}) }
  before  { subject.apply }

  describe 'edge' do
    let(:opts) { { edge: true } }

    it { expect(node.value).to eq 'value' }
    it { expect(node.msgs).to include [:info, :key, :edge, given: :key] }
  end

  describe 'flagged' do
    let(:opts) { { flagged: true } }

    it { expect(node.value).to eq 'value' }
    it { expect(node.msgs).to include [:info, :key, :flagged, given: :key] }
  end

  describe 'deprecated' do
    let(:opts) { { deprecated: :info } }

    it { expect(node.value).to eq 'value' }
    it { expect(node.msgs).to include [:warn, :key, :deprecated, given: :key, info: :info] }
  end
end
