describe Travis::Yaml::Spec::Def::Scala do
  let(:spec)     { Travis::Yaml.spec }
  let(:support)  { Travis::Yaml.support }
  let(:lang)     { spec[:map][:language][:types][0] }
  let(:scala)    { support[:map][:scala][:types][0] }
  let(:jdk)      { support[:map][:jdk][:types][0] }
  let(:sbt_args) { support[:map][:sbt_args][:types][0] }

  it { expect(lang[:values]).to include(value: 'scala') }
  it { expect(scala[:only][:language]).to include('scala') }
  it { expect(jdk[:only][:language]).to include('scala') }
  it { expect(sbt_args[:only][:language]).to include('scala') }
end
