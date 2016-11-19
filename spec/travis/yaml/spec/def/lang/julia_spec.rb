describe Travis::Yaml::Spec::Def::Julia do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:julia)   { support[:map][:julia][:types][0] }

  it { expect(lang[:values]).to include(value: 'julia') }
  it { expect(julia[:only][:language]).to include('julia') }
end
