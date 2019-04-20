describe Travis::Yml::Schema::Def::R, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:r] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :r,
        title: 'R',
        type: :object,
        properties: {
          r: {
            '$ref': '#/definitions/strs'
          },
          r_packages: {
            '$ref': '#/definitions/strs'
          },
          r_binary_packages: {
            '$ref': '#/definitions/strs'
          },
          r_github_packages: {
            '$ref': '#/definitions/strs'
          },
          apt_packages: {
            '$ref': '#/definitions/strs'
          },
          bioc_packages: {
            '$ref': '#/definitions/strs'
          },
          brew_packages: {
            '$ref': '#/definitions/strs'
          },
          bioc: {
            type: :string
          },
          bioc_check: {
            type: :boolean
          },
          bioc_required: {
            type: :boolean
          },
          bioc_use_devel: {
            type: :boolean
          },
          cran: {
            type: :string
          },
          disable_homebrew: {
            type: :boolean
          },
          latex: {
            type: :boolean
          },
          pandoc: {
            type: :boolean
          },
          pandoc_version: {
            type: :string
          },
          r_build_args: {
            type: :string
          },
          r_check_args: {
            type: :string
          },
          r_check_revdep: {
            type: :boolean
          },
          warnings_are_errors: {
            type: :boolean
          },
          remotes: {
            type: :string
          },
          repos: {
            type: :object
          }
        },
        normal: true,
        only: {
          r: {
            language: [
              'r'
            ]
          },
          r_packages: {
            language: [
              'r'
            ]
          },
          r_binary_packages: {
            language: [
              'r'
            ]
          },
          r_github_packages: {
            language: [
              'r'
            ]
          },
          apt_packages: {
            language: [
              'r'
            ]
          },
          bioc_packages: {
            language: [
              'r'
            ]
          },
          brew_packages: {
            language: [
              'r'
            ]
          },
          bioc: {
            language: [
              'r'
            ]
          },
          bioc_check: {
            language: [
              'r'
            ]
          },
          bioc_required: {
            language: [
              'r'
            ]
          },
          bioc_use_devel: {
            language: [
              'r'
            ]
          },
          cran: {
            language: [
              'r'
            ]
          },
          disable_homebrew: {
            language: [
              'r'
            ]
          },
          latex: {
            language: [
              'r'
            ]
          },
          pandoc: {
            language: [
              'r'
            ]
          },
          pandoc_version: {
            language: [
              'r'
            ]
          },
          r_build_args: {
            language: [
              'r'
            ]
          },
          r_check_args: {
            language: [
              'r'
            ]
          },
          r_check_revdep: {
            language: [
              'r'
            ]
          },
          warnings_are_errors: {
            language: [
              'r'
            ]
          },
          remotes: {
            language: [
              'r'
            ]
          },
          repos: {
            language: [
              'r'
            ]
          }
        },
        aliases: {
          bioc_required: [
            :use_bioc
          ]
        }
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/language/r'
  #     )
  #   end
  # end
end
