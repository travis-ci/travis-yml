describe Travis::Yaml::Spec::Def::Haskell do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:ghc)     { support[:map][:ghc][:types][0] }

  it { expect(lang[:values]).to include(value: 'haskell') }
  it { expect(ghc[:only][:language]).to include('haskell') }
end
