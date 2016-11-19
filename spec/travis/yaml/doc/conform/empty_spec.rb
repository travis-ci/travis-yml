describe Travis::Yaml::Doc::Conform::Empty do
  let(:root) { Travis::Yaml.build(lang: 'RUBY') }

  subject { described_class.new(node) }

  describe 'given a map' do
    let(:node) { Travis::Yaml::Doc::Type::Map.new(root, :map, {}, { given: true }) }

    describe 'apply?' do
      it { expect(subject.apply?).to be true }
    end

    describe 'apply' do
      before { subject.apply }

      it { expect(node.present?).to be false }
      it { expect(root.msgs).to include [:error, :root, :empty, 'dropping empty section :map'] }
    end
  end

  describe 'given a seq' do
    let(:node) { Travis::Yaml::Doc::Type::Seq.new(root, :seq, [], { given: true }) }

    describe 'apply?' do
      it { expect(subject.apply?).to be true }
    end

    describe 'apply' do
      before { subject.apply }

      it { expect(node.present?).to be false }
      it { expect(root.msgs).to include [:error, :root, :empty, 'dropping empty section :seq'] }
    end
  end
end
