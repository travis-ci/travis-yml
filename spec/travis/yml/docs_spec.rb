describe Travis::Yml::Docs do
  let(:root) { described_class.root }

  describe 'root' do
    it { expect(root.render).to include '# Root' }
    it { expect(root.render).to include '* `version`' }
    it { expect(root.render).to include '* `group`' }
    it { expect(root.path).to eq '/v1/docs/root' }
    # it { puts root.render }
    # it { puts root[:import].render }
  end

  # describe 'pages' do
  #   let(:pages) { described_class.pages }
  #   it { p pages.keys }
  # end

  # describe 'walk' do
  #   let(:ids) { [] }
  #   before { root.walk { |node| ids << node.id } }
  #   it { p ids }
  # end
end
