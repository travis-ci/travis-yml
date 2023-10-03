describe Travis::Yml, 'r' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'r' do
    describe 'given a seq of strs' do
      yaml %(
        r:
        - str
      )
      it { should serialize_to r: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        r: str
      )
      it { should serialize_to r: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'r_packages' do
    describe 'given a seq of strs' do
      yaml %(
        r_packages:
        - str
      )
      it { should serialize_to r_packages: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        r_packages: str
      )
      it { should serialize_to r_packages: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'r_binary_packages' do
    describe 'given a seq of strs' do
      yaml %(
        r_binary_packages:
        - str
      )
      it { should serialize_to r_binary_packages: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        r_binary_packages: str
      )
      it { should serialize_to r_binary_packages: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'r_github_packages' do
    describe 'given a seq of strs' do
      yaml %(
        r_github_packages:
        - str
      )
      it { should serialize_to r_github_packages: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        r_github_packages: str
      )
      it { should serialize_to r_github_packages: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'apt_packages' do
    describe 'given a seq of strs' do
      yaml %(
        apt_packages:
        - str
      )
      it { should serialize_to apt_packages: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        apt_packages: str
      )
      it { should serialize_to apt_packages: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'bioc_packages' do
    describe 'given a seq of strs' do
      yaml %(
        bioc_packages:
        - str
      )
      it { should serialize_to bioc_packages: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        bioc_packages: str
      )
      it { should serialize_to bioc_packages: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'brew_packages' do
    describe 'given a seq of strs' do
      yaml %(
        brew_packages:
        - str
      )
      it { should serialize_to brew_packages: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        brew_packages: str
      )
      it { should serialize_to brew_packages: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'bioc' do
    describe 'given a str' do
      yaml %(
        bioc: str
      )
      it { should serialize_to bioc: 'str' }
      it { should_not have_msg }
    end
  end

  describe 'bioc_check' do
    describe 'given a bool' do
      yaml %(
        bioc_check: true
      )
      it { should serialize_to bioc_check: true }
      it { should_not have_msg }
    end
  end

  describe 'bioc_required' do
    describe 'given a bool' do
      yaml %(
        bioc_required: true
      )
      it { should serialize_to bioc_required: true }
      it { should_not have_msg }
    end
  end

  describe 'bioc_use_devel' do
    describe 'given a bool' do
      yaml %(
        bioc_use_devel: true
      )
      it { should serialize_to bioc_use_devel: true }
      it { should_not have_msg }
    end
  end

  describe 'cran' do
    describe 'given a str' do
      yaml %(
        cran: str
      )
      it { should serialize_to cran: 'str' }
      it { should_not have_msg }
    end
  end

  describe 'disable_homebrew' do
    describe 'given a bool' do
      yaml %(
        disable_homebrew: true
      )
      it { should serialize_to disable_homebrew: true }
      it { should_not have_msg }
    end
  end

  describe 'latex' do
    describe 'given a bool' do
      yaml %(
        latex: true
      )
      it { should serialize_to latex: true }
      it { should_not have_msg }
    end
  end

  describe 'pandoc' do
    describe 'given a bool' do
      yaml %(
        pandoc: true
      )
      it { should serialize_to pandoc: true }
      it { should_not have_msg }
    end
  end

  describe 'pandoc_version' do
    describe 'given a str' do
      yaml %(
        pandoc_version: str
      )
      it { should serialize_to pandoc_version: 'str' }
      it { should_not have_msg }
    end
  end

  describe 'r_build_args' do
    describe 'given a str' do
      yaml %(
        r_build_args: str
      )
      it { should serialize_to r_build_args: 'str' }
      it { should_not have_msg }
    end
  end

  describe 'r_check_args' do
    describe 'given a str' do
      yaml %(
        r_check_args: str
      )
      it { should serialize_to r_check_args: 'str' }
      it { should_not have_msg }
    end
  end

  describe 'r_check_revdep' do
    describe 'given a bool' do
      yaml %(
        r_check_revdep: true
      )
      it { should serialize_to r_check_revdep: true }
      it { should_not have_msg }
    end
  end

  describe 'warnings_are_errors' do
    describe 'given a bool' do
      yaml %(
        warnings_are_errors: true
      )
      it { should serialize_to warnings_are_errors: true }
      it { should_not have_msg }
    end
  end

  describe 'remotes' do
    describe 'given a str' do
      yaml %(
        remotes: str
      )
      it { should serialize_to remotes: 'str' }
      it { should_not have_msg }
    end
  end

  describe 'repos' do
    describe 'given a str', drop: true do
      yaml %(
        repos: str
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :repos, :invalid_type, expected: :map, actual: :str, value: 'str'] }
    end

    describe 'given a map' do
      yaml %(
        repos:
          ONE: str
          two: str
      )
      it { should serialize_to repos: { ONE: 'str', two: 'str' } }
      it { should_not have_msg }
    end
  end

  describe 'use_devtools' do
    describe 'given a bool' do
      yaml %(
        use_devtools: true
      )
      it { should serialize_to use_devtools: true }
      it { should_not have_msg }
    end
  end
end
