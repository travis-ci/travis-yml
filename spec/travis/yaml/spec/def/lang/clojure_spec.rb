describe Travis::Yaml::Spec::Def::Clojure do
  let(:spec)    { Travis::Yaml.spec }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:jdks)    { spec[:map][:jdk][:types][0] }

  it { expect(lang[:values]).to include(value: 'clojure') }
  it { expect(jdks[:only][:language]).to include('clojure') }
end

