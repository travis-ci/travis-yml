describe Travis::Yaml::Doc::Conform::Pick do
  let(:root) { Travis::Yaml.build(lang: 'ruby') }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, ['value'], {}) }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to eq 'value' }
    it { expect(root.msgs).to include [:warn, :key, :invalid_seq, 'unexpected sequence, using the first value ("value")'] }
  end
end
