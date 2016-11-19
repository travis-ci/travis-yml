describe Travis::Yaml::Spec::Def::Android do
  let(:spec)    { Travis::Yaml.spec }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:jdks)    { spec[:map][:jdk][:types][0] }
  let(:android) { spec[:map][:android][:types][0] }

  it { expect(lang[:values]).to include(value: 'android') }

  it { expect(jdks[:only][:language]).to include('android') }
  it { expect(android[:only][:language]).to include('android') }
end
