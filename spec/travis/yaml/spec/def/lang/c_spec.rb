describe Travis::Yaml::Spec::Def::C do
  let(:spec)      { Travis::Yaml.spec }
  let(:support)   { Travis::Yaml.support }
  let(:lang)      { spec[:map][:language][:types][0] }

  it { expect(lang[:values]).to include(value: 'c') }
end
