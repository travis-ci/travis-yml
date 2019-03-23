describe Travis::Yaml::Spec::Def::Clojure do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:jdks)    { support[:map][:jdk][:types][0] }

  it { expect(lang[:values]).to include(value: 'clojure') }
  it { expect(jdks[:only][:language]).to include('clojure') }
end

