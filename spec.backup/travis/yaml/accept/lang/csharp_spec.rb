describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'csharp', dotnet: 'dotnet', mono: 'mono', solution: 'solution' } }

  it { expect(config[:language]).to eq 'csharp' }
  it { expect(config[:dotnet]).to eq ['dotnet'] }
  it { expect(config[:mono]).to eq ['mono'] }
  it { expect(config[:solution]).to eq ['solution'] }
end
