describe Travis::Yaml::Spec::Def::Erlang do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:otp_release) { spec[:map][:otp_release][:types][0] }
  
  it { expect(lang[:values]).to include(value: 'erlang') }
  it { expect(otp_release[:only][:language]).to include('erlang') }
end