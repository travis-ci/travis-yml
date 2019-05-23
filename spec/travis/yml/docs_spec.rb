describe Travis::Yml::Docs do
  let(:root) { described_class.root }

  describe 'root' do
    it { expect(root.render).to include '# Root' }
    it { expect(root.render).to include '* `version`' }
    it { expect(root.render).to include '* `group`' }
    it { expect(root.path).to eq '/ref/root' }
    it { puts root.render }
  end

  describe 'walk' do
    let(:ids) { [] }
    before { root.walk { |node| ids << node.id } }
    it { p ids }
  end

  describe 'walk' do
    let(:ids) { [] }
    it { root.walk { |node| puts node.render } }
  end
end
