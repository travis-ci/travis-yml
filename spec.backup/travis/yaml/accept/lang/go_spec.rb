describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'go', go: '1.3', gobuild_args: 'args', go_import_path: 'path' } }

  it { expect(config[:language]).to eq 'go' }
  it { expect(config[:go]).to eq ['1.3'] }
  it { expect(config[:gobuild_args]).to eq 'args' }
  it { expect(config[:go_import_path]).to eq 'path' }

  describe 'gimme_config' do
    let(:input) { { language: 'go', gimme_config: { url: 'url', force_reinstall: true } } }
    it { expect(config[:gimme_config]).to eq url: 'url', force_reinstall: true }
  end
end
