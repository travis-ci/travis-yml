describe Travis::Yaml::Spec::Def::R do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }
  let(:r)       { support[:map][:r][:types][0] }

  let(:apt_packages)        { support[:map][:apt_packages][:types][0] }
  let(:bioc_check)          { support[:map][:bioc_check][:types][0] }
  let(:bioc_packages)       { support[:map][:bioc_packages][:types][0] }
  let(:bioc_required)       { support[:map][:bioc_required][:types][0] }
  let(:bioc_use_devel)      { support[:map][:bioc_use_devel][:types][0] }
  let(:brew_packages)       { support[:map][:brew_packages][:types][0] }
  let(:cran)                { support[:map][:cran][:types][0] }
  let(:disable_homebrew)    { support[:map][:disable_homebrew][:types][0] }
  let(:latex)               { support[:map][:latex][:types][0] }
  let(:pandoc)              { support[:map][:pandoc][:types][0] }
  let(:pandoc_version)      { support[:map][:pandoc_version][:types][0] }
  let(:r_binary_packages)   { support[:map][:r_binary_packages][:types][0] }
  let(:r_build_args)        { support[:map][:r_build_args][:types][0] }
  let(:r_check_args)        { support[:map][:r_check_args][:types][0] }
  let(:r_check_revdep)      { support[:map][:r_check_revdep][:types][0] }
  let(:r_github_packages)   { support[:map][:r_github_packages][:types][0] }
  let(:r_packages)          { support[:map][:r_packages][:types][0] }
  let(:warnings_are_errors) { support[:map][:warnings_are_errors][:types][0] }
  let(:remotes)             { support[:map][:remotes][:types][0] }
  let(:repos)               { support[:map][:repos][:types][0] }

  it { expect(lang[:values]).to include(value: 'r') }
  it { expect(r[:only][:language]).to include('r') }
  it { expect(apt_packages[:only][:language]).to include('r') }
  it { expect(bioc_check[:only][:language]).to include('r') }
  it { expect(bioc_packages[:only][:language]).to include('r') }
  it { expect(bioc_required[:only][:language]).to include('r') }
  it { expect(bioc_use_devel[:only][:language]).to include('r') }
  it { expect(brew_packages[:only][:language]).to include('r') }
  it { expect(cran[:only][:language]).to include('r') }
  it { expect(disable_homebrew[:only][:language]).to include('r') }
  it { expect(latex[:only][:language]).to include('r') }
  it { expect(pandoc[:only][:language]).to include('r') }
  it { expect(pandoc_version[:only][:language]).to include('r') }
  it { expect(r_binary_packages[:only][:language]).to include('r') }
  it { expect(r_build_args[:only][:language]).to include('r') }
  it { expect(r_check_args[:only][:language]).to include('r') }
  it { expect(r_check_revdep[:only][:language]).to include('r') }
  it { expect(r_github_packages[:only][:language]).to include('r') }
  it { expect(r_packages[:only][:language]).to include('r') }
  it { expect(warnings_are_errors[:only][:language]).to include('r') }
  it { expect(remotes[:only][:language]).to include('r') }
  it { expect(repos[:only][:language]).to include('r') }
end
