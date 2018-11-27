describe Travis::Yaml::Spec::Def::Elm do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:elm)        { support[:map][:elm][:types][0] }
  let(:elm_test)   { support[:map][:elm_test][:types][0] }
  let(:elm_format) { support[:map][:elm_format][:types][0] }

  it { expect(lang[:values]).to include(value: 'elm') }
  it { expect(elm[:only][:language]).to include('elm') }
  it { expect(elm_test[:only][:language]).to include('elm') }
  it { expect(elm_format[:only][:language]).to include('elm') }

end
