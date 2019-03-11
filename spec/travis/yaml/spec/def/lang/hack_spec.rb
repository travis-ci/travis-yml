describe Travis::Yaml::Spec::Def::Hack do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:hhvm)    { support[:map][:hhvm][:types][0] }

  it { expect(lang[:values]).to include(value: 'hack') }
  it { expect(hhvm[:only][:language]).to include('hack') }

end
