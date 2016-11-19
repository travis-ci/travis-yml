describe Travis::Yaml::Spec::Def::Shell do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }

  it { expect(lang[:values]).to include(value: 'shell', alias: ['generic', 'bash', 'sh', 'minimal']) }
end
