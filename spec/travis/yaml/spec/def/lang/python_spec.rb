describe Travis::Yaml::Spec::Def::Python do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:python) { spec[:map][:python][:types][0] }
  let(:virtualenv) { spec[:map][:virtualenv][:types][0] }

  it { expect(lang[:values]).to include(value: 'python') }
  it { expect(python[:only][:language]).to include('python') }
  it { expect(virtualenv[:only][:language]).to include('python') }
end
