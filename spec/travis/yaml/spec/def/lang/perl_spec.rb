describe Travis::Yaml::Spec::Def::Perl do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:perl) { spec[:map][:perl][:types][0] }
  
  it { expect(lang[:values]).to include(value: 'perl') }
  it { expect(perl[:only][:language]).to include('perl') }
end