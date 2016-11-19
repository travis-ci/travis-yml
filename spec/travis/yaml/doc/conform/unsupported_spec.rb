describe Travis::Yaml::Doc::Conform::Unsupported do
  let(:root) { Travis::Yaml.build(language: 'ruby') }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, 'value', opts) }
  let(:opts) { { except: { language: 'ruby' } } }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply? }
    before { subject.apply }

    it { expect(node.value).to be nil }
    it { expect(root.msgs).to include [:error, :key, :unsupported, 'key ("value") is not supported on language "ruby"'] }
  end
end
