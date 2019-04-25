describe Travis::Yml::Schema::Def::R, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:r] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_r,
        title: 'Language R',
        type: :object,
        properties: {
          r: {
            '$ref': '#/definitions/type/strs'
          },
          r_packages: {
            '$ref': '#/definitions/type/strs'
          },
          r_binary_packages: {
            '$ref': '#/definitions/type/strs'
          },
          r_github_packages: {
            '$ref': '#/definitions/type/strs'
          },
          apt_packages: {
            '$ref': '#/definitions/type/strs'
          },
          bioc_packages: {
            '$ref': '#/definitions/type/strs'
          },
          brew_packages: {
            '$ref': '#/definitions/type/strs'
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
        keys: {
          r: {
            only: {
              language: [
                'r'
              ]
            }
          },
          r_packages: {
            only: {
              language: [
                'r'
              ]
            }
          },
          r_binary_packages: {
            only: {
              language: [
                'r'
              ]
            }
          },
          r_github_packages: {
            only: {
              language: [
                'r'
              ]
            }
          },
          apt_packages: {
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_packages: {
            only: {
              language: [
                'r'
              ]
            }
          },
          brew_packages: {
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc: {
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_check: {
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_required: {
            aliases: [
              :use_bioc
            ],
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_use_devel: {
            only: {
              language: [
                'r'
              ]
            }
          },
          cran: {
            only: {
              language: [
                'r'
              ]
            }
          },
          disable_homebrew: {
            only: {
              language: [
                'r'
              ]
            }
          },
          latex: {
            only: {
              language: [
                'r'
              ]
            }
          },
          pandoc: {
            only: {
              language: [
                'r'
              ]
            }
          },
          pandoc_version: {
            only: {
              language: [
                'r'
              ]
            }
          },
          r_build_args: {
            only: {
              language: [
                'r'
              ]
            }
          },
          r_check_args: {
            only: {
              language: [
                'r'
              ]
            }
          },
          r_check_revdep: {
            only: {
              language: [
                'r'
              ]
            }
          },
          warnings_are_errors: {
            only: {
              language: [
                'r'
              ]
            }
          },
          remotes: {
            only: {
              language: [
                'r'
              ]
            }
          },
          repos: {
            only: {
              language: [
                'r'
              ]
            }
          }
        }
      )
    end
  end
end
