describe Travis::Yaml::Spec::Def::Clojure do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:d)       { support[:map][:d][:types][0] }

  it { expect(lang[:values]).to include(value: 'd') }
  it { expect(d[:only][:language]).to include('d') }
end
