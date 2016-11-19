describe Travis::Yaml::Spec::Def::Clojure do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:d)    { spec[:map][:d][:types][0] }

  it { expect(lang[:values]).to include(value: 'd') }
  it { expect(d[:only][:language]).to include('d') }
end
