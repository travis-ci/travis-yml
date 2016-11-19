describe Travis::Yaml::Spec::Def::Php do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:php)     { support[:map][:php][:types][0] }
  let(:composer_args) { support[:map][:composer_args][:types][0] }

  it { expect(lang[:values]).to include(value: 'php') }
  it { expect(php[:only][:language]).to include('php') }
  it { expect(composer_args[:only][:language]).to include('php') }
end
