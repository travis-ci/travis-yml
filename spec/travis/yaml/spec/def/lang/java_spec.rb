describe Travis::Yaml::Spec::Def::Java do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:jdk) { spec[:map][:jdk][:types][0] }

  it { expect(lang[:values]).to include(value: 'java', alias: ['jvm']) }
  it { expect(jdk[:only][:language]).to include('java') }
end
