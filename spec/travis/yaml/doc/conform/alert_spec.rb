describe Travis::Yaml::Doc::Conform::Alert do
  let(:root) { Travis::Yaml.build({}) }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, 'value', opts) }
  let(:opts) { { alert: true, cast: [:secure] } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to be_nil }
    it { expect(root.msgs).to include [:error, :key, :alert, 'using a plain string as a secure'] }
  end
end
