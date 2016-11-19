describe Travis::Yaml::Doc::Conform::Downcase do
  let(:root) { Travis::Yaml.build(language: 'RUBY') }
  let(:node) { root.children.first }

  subject { described_class.new(node) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(node.value).to eq 'ruby' }
    it { expect(root.msgs).to include [:info, :language, :downcase, 'downcasing "RUBY"'] }
  end
end
