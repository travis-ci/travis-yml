describe Travis::Yaml::Spec::Def::Csharp do
  let(:spec)     { Travis::Yaml.spec }
  let(:lang)     { spec[:map][:language][:types][0] }
  let(:dotnet)   { spec[:map][:dotnet][:types][0] }
  let(:mono)     { spec[:map][:mono][:types][0] }
  let(:solution) { spec[:map][:solution][:types][0] }

  it { expect(lang[:values]).to include(value: 'csharp') }
  it { expect(dotnet[:only][:language]).to include('csharp') }
  it { expect(mono[:only][:language]).to include('csharp') }
  it { expect(solution[:only][:language]).to include('csharp') }
end
