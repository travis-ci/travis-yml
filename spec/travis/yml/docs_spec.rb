describe Travis::Yml::Docs do
  let(:pages) { described_class.pages }
  let(:root) { described_class.root(path: nil) }

  describe 'root' do
    it { expect(root.render).to include '# Travis CI Build Config Reference' }
    it { expect(root.render).to include '* `import`' }
    it { expect(root.render).to include '* `addons`' }
    it { expect(root.path).to eq '/' }
  end
end
