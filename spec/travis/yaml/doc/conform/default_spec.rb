describe Travis::Yaml::Doc::Conform::Default do
  let(:root) { Travis::Yaml.build({}) }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, nil, opts) }
  let(:opts) { { defaults: [value: 'default'] } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to eq 'default' }
    it { expect(root.msgs).to include [:info, :key, :default, 'missing :key, defaulting to "default"'] }
  end
end
