describe Travis::Yml::Docs do
  let(:pages) { described_class.pages }
  let(:root) { described_class.root(path: '/path/to') }

  describe 'root' do
    it { expect(root.render).to include '# Root' }
    it { expect(root.render).to include '* `import`' }
    it { expect(root.render).to include '* `addons`' }
    it { expect(root.path).to eq '/path/to/node/root' }
  end
end
