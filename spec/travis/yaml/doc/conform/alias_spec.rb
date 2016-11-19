describe Travis::Yaml::Doc::Conform::Alias do
  let(:root) { Travis::Yaml.build(language: 'jvm') }
  let(:node) { root.children.first }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to eq 'java' }
    it { expect(root.msgs).to include [:info, :language, :alias, '"jvm" is an alias for "java", using "java"'] }
  end
end
