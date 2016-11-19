describe Travis::Yaml::Spec::Def::Csharp do
  let(:spec)     { Travis::Yaml.spec }
  let(:support)  { Travis::Yaml.support }
  let(:lang)     { spec[:map][:language][:types][0] }
  let(:dotnet)   { support[:map][:dotnet][:types][0] }
  let(:mono)     { support[:map][:mono][:types][0] }
  let(:solution) { support[:map][:solution][:types][0] }

  it { expect(lang[:values]).to include(value: 'csharp', alias: ['c#', 'fsharp', 'f#']) }
  it { expect(dotnet[:only][:language]).to include('csharp') }
  it { expect(mono[:only][:language]).to include('csharp') }
  it { expect(solution[:only][:language]).to include('csharp') }
end
