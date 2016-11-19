describe Travis::Yaml::Spec::Def::R do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:r) { spec[:map][:r][:types][0] }
  let(:apt_packages) { spec[:map][:apt_packages][:types][0] }
  let(:bioc_packages) { spec[:map][:bioc_packages][:types][0] }
  let(:bioc_required) { spec[:map][:bioc_required][:types][0] }
  let(:bioc_use_devel) { spec[:map][:bioc_use_devel][:types][0] }
  let(:brew_packages) { spec[:map][:brew_packages][:types][0] }
  let(:cran) { spec[:map][:cran][:types][0] }
  let(:disable_homebrew) { spec[:map][:disable_homebrew][:types][0] }
  let(:latex) { spec[:map][:latex][:types][0] }
  let(:pandoc) { spec[:map][:pandoc][:types][0] }
  let(:pandoc_version) { spec[:map][:pandoc_version][:types][0] }
  let(:r_binary_packages) { spec[:map][:r_binary_packages][:types][0] }
  let(:r_build_args) { spec[:map][:r_build_args][:types][0] }
  let(:r_check_args) { spec[:map][:r_check_args][:types][0] }
  let(:r_check_revdep) { spec[:map][:r_check_revdep][:types][0] }
  let(:r_github_packages) { spec[:map][:r_github_packages][:types][0] }
  let(:r_packages) { spec[:map][:r_packages][:types][0] }
  let(:warnings_are_errors) { spec[:map][:warnings_are_errors][:types][0] }
  let(:remotes) { spec[:map][:Remotes][:types][0] }
  let(:repos) { spec[:map][:repos][:types][0] }
  
  it { expect(lang[:values]).to include(value: 'r') }
  it { expect(r[:only][:language]).to include('r') }
  it { expect(apt_packages[:only][:language]).to include('r') }
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