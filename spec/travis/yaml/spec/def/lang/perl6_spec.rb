describe Travis::Yaml::Spec::Def::Perl6 do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:perl6)   { support[:map][:perl6][:types][0] }

  it { expect(lang[:values]).to include(value: 'perl6') }
  it { expect(perl6[:only][:language]).to include('perl6') }
end
