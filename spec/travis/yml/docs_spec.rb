describe Travis::Yml::Docs do
  let(:pages) { described_class.pages }
  let(:root) { described_class.root }

  describe 'root' do
    it { expect(root.render).to include '# Root' }
    it { expect(root.render).to include '* `import`' }
    it { expect(root.render).to include '* `group`' }
    it { expect(root.path).to eq '/v1/docs/root' }
    # it { puts root.render }
  end

  # describe 'pages' do
  #   # it { p pages.keys }
  #   it { puts pages[:job].render }
  # end

  describe 'index' do
    # it { puts described_class.index('addons') }
  end
end
