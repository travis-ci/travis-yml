describe Travis::Yaml::Spec::Def::Go do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:go)      { support[:map][:go][:types][0] }
  let(:gobuild_args) { support[:map][:gobuild_args][:types][0] }
  let(:go_import_path) { support[:map][:go_import_path][:types][0] }

  it { expect(lang[:values]).to include(value: 'go', alias: ['golang']) }
  it { expect(go[:only][:language]).to include('go') }
  it { expect(gobuild_args[:only][:language]).to include('go') }
  it { expect(go_import_path[:only][:language]).to include('go') }
end
