describe Travis::Yaml::Spec::Def::ObjectiveC do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }

  let(:xcode_sdk)       { support[:map][:xcode_sdk][:types][0] }
  let(:podfile)         { support[:map][:podfile][:types][0] }
  let(:xcode_scheme)    { support[:map][:xcode_scheme][:types][0] }
  let(:xcode_project)   { support[:map][:xcode_project][:types][0] }
  let(:xcode_workspace) { support[:map][:xcode_workspace][:types][0] }
  let(:xctool_args)     { support[:map][:xctool_args][:types][0] }

  it { expect(lang[:values]).to include(value: 'objective-c', alias: ['objc', 'obj_c', 'objective_c', 'swift']) }

  it { expect(xcode_sdk[:only][:language]).to include('objective-c') }
  it { expect(podfile[:only][:language]).to include('objective-c') }
  it { expect(xcode_scheme[:only][:language]).to include('objective-c') }
  it { expect(xcode_project[:only][:language]).to include('objective-c') }
  it { expect(xcode_workspace[:only][:language]).to include('objective-c') }
  it { expect(xctool_args[:only][:language]).to include('objective-c') }
end
