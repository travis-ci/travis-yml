describe Travis::Yaml::Spec::Def::Smalltalk do
  let(:spec)      { Travis::Yaml.spec }
  let(:support)   { Travis::Yaml.support }
  let(:lang)      { spec[:map][:language][:types][0] }
  let(:smalltalk) { support[:map][:smalltalk][:types][0] }
  let(:smalltalk_config) { support[:map][:smalltalk_config][:types][0] }

  it { expect(lang[:values]).to include(value: 'smalltalk') }
  it { expect(smalltalk[:only][:language]).to include('smalltalk') }
  it { expect(smalltalk_config[:only][:language]).to include('smalltalk') }
end
