describe Travis::Yaml::Spec::Def::Rust do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:rust) { spec[:map][:rust][:types][0] }
  
  it { expect(lang[:values]).to include(value: 'rust') }
  it { expect(rust[:only][:language]).to include('rust') }
end