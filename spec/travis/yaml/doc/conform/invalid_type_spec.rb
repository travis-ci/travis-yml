describe Travis::Yaml::Doc::Conform::InvalidType do
  let(:root) { Travis::Yaml.build(lang: 'ruby') }
  let(:opts) { { given: true } }
  let(:node) { type.new(root, :key, value, opts) }

  subject { described_class.new(node) }

  describe 'given a scalar' do
    let(:type)  { Travis::Yaml::Doc::Type::Scalar }
    let(:value) { { foo: 'foo' } }

    describe 'apply?' do
      it { expect(subject.apply?).to be true }
    end

    describe 'apply' do
      before { subject.apply }

      it { expect(node.value).to be_nil }
      it { expect(root.msgs).to include [:error, :key, :invalid_type, 'dropping unexpected Hash ({:foo=>"foo"})'] }
    end
  end

  describe 'given a map' do
    let(:type)  { Travis::Yaml::Doc::Type::Map }
    let(:value) { 'foo' }

    describe 'apply?' do
      it { expect(subject.apply?).to be true }
    end

    describe 'apply' do
      before { subject.apply }

      it { expect(node.children).to be_empty }
      it { expect(root.msgs).to include [:error, :key, :invalid_type, 'dropping unexpected String ("foo")'] }
    end
  end

  describe 'given a seq' do
    let(:type)  { Travis::Yaml::Doc::Type::Seq }
    let(:value) { 'foo' }

    describe 'apply?' do
      it { expect(subject.apply?).to be true }
    end

    describe 'apply' do
      before { subject.apply }

      it { expect(node.children).to be_empty }
      it { expect(root.msgs).to include [:error, :key, :invalid_type, 'dropping unexpected String ("foo")'] }
    end
  end
end
