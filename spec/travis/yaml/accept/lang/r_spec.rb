describe Travis::Yaml do
  let(:config) { subject.serialize }

  subject { described_class.apply(input) }

  let(:input) do
    {
      language: 'r',
      r: 'devel',
      r_packages: 'package',
      r_binary_packages: 'package',
      r_github_packages: 'package',
      apt_packages: 'package',
      bioc_packages: 'package',
      brew_packages: 'package',
      bioc_check: true,
      bioc_required: true,
      bioc_use_devel: true,
      cran: 'https://cloud.r-project.org',
      disable_homebrew: true,
      latex: true,
      pandoc: true,
      pandoc_version: '1.16',
      r_build_args: 'args',
      r_check_args: 'args',
      r_check_revdep: true,
      warnings_are_errors: true,
      remotes: 'user/repo',
      repos: { foo: 'foo' }
    }
  end

  it { expect(config[:language]).to eq 'r' }

  it { expect(config[:r]).to                   eq ['devel'] }
  it { expect(config[:apt_packages]).to        eq ['package'] }
  it { expect(config[:bioc_packages]).to       eq ['package'] }
  it { expect(config[:brew_packages]).to       eq ['package'] }
  it { expect(config[:r_binary_packages]).to   eq ['package'] }
  it { expect(config[:r_github_packages]).to   eq ['package'] }
  it { expect(config[:r_packages]).to          eq ['package'] }
  it { expect(config[:bioc_check]).to       eq true }
  it { expect(config[:bioc_required]).to       eq true }
  it { expect(config[:bioc_use_devel]).to      eq true }
  it { expect(config[:cran]).to                eq 'https://cloud.r-project.org' }
  it { expect(config[:disable_homebrew]).to    eq true }
  it { expect(config[:latex]).to               eq true }
  it { expect(config[:pandoc]).to              eq true }
  it { expect(config[:pandoc_version]).to      eq '1.16' }
  it { expect(config[:r_build_args]).to        eq 'args' }
  it { expect(config[:r_check_args]).to        eq 'args' }
  it { expect(config[:r_check_revdep]).to      eq true }
  it { expect(config[:warnings_are_errors]).to eq true }
  it { expect(config[:remotes]).to             eq 'user/repo' }
  it { expect(config[:repos]).to               eq foo: 'foo' }
end
