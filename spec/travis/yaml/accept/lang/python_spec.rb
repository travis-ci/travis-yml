describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'python', python: '2.7', virtualenv: { system_site_packages: true } } }

  it { expect(config[:language]).to eq 'python' }
  it { expect(config[:python]).to eq ['2.7'] }
  it { expect(config[:virtualenv]).to eq system_site_packages: true }
end
