describe Travis::Yaml::Spec::Def::Nix do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }

  it { expect(lang[:values]).to include(value: 'nix') }
end
