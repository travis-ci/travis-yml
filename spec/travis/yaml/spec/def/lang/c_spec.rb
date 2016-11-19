describe Travis::Yaml::Spec::Def::C do
  let(:spec)      { Travis::Yaml.spec }
  let(:lang)      { spec[:map][:language][:types][0] }
  let(:compilers) { spec[:map][:compiler][:types][0] }

  it { expect(lang[:values]).to include(value: 'c') }
  it { expect(compilers[:only][:language]).to include('c') }
end

describe Travis::Yaml::Spec::Def::Cpp do
  let(:spec)      { Travis::Yaml.spec }
  let(:lang)      { spec[:map][:language][:types][0] }
  let(:compilers) { spec[:map][:compiler][:types][0] }

  it { expect(lang[:values]).to include(value: 'cpp', alias: ['c++']) }
  it { expect(compilers[:only][:language]).to include('cpp') }
end
