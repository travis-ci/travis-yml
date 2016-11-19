describe Travis::Yaml::Spec::Def::ObjectiveC do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }

  let(:xcode_sdk)       { spec[:map][:xcode_sdk][:types][0] }
  let(:podfile)         { spec[:map][:podfile][:types][0] }
  let(:xcode_scheme)    { spec[:map][:xcode_scheme][:types][0] }
  let(:xcode_project)   { spec[:map][:xcode_project][:types][0] }
  let(:xcode_workspace) { spec[:map][:xcode_workspace][:types][0] }
  let(:xctool_args)     { spec[:map][:xctool_args][:types][0] }

  it { expect(lang[:values]).to include(value: 'objective_c', alias: ['objc', 'obj_c', 'objective-c', 'swift']) }

  it { expect(xcode_sdk[:only][:language]).to include('objective_c') }
  it { expect(podfile[:only][:language]).to include('objective_c') }
  it { expect(xcode_scheme[:only][:language]).to include('objective_c') }
  it { expect(xcode_project[:only][:language]).to include('objective_c') }
  it { expect(xcode_workspace[:only][:language]).to include('objective_c') }
  it { expect(xctool_args[:only][:language]).to include('objective_c') }
end
