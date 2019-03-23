describe Travis::Yaml::Spec::Def::Python do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:python)  { support[:map][:python][:types][0] }
  let(:virtualenv) { support[:map][:virtualenv][:types][0] }

  it { expect(lang[:values]).to include(value: 'python') }
  it { expect(python[:only][:language]).to include('python') }
  it { expect(virtualenv[:only][:language]).to include('python') }
end
