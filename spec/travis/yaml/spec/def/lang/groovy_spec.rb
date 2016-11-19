describe Travis::Yaml::Spec::Def::Groovy do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:jdk)     { support[:map][:jdk][:types][0] }

  it { expect(lang[:values]).to include(value: 'groovy') }
  it { expect(jdk[:only][:language]).to include('groovy') }
end
