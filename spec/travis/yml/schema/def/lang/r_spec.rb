describe Travis::Yml::Schema::Def::R do
  subject { Travis::Yml.schema[:definitions][:language][:r] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :r,
        title: 'R',
        summary: kind_of(String),
        see: kind_of(Hash),
        type: :object,
        properties: {
          r: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'r'
              ]
            }
          },
          r_packages: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'r'
              ]
            }
          },
          r_binary_packages: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'r'
              ]
            }
          },
          r_github_packages: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'r'
              ]
            }
          },
          apt_packages: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_packages: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'r'
              ]
            }
          },
          brew_packages: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc: {
            type: :string,
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_check: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          bioc_required: {
            type: :boolean,
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
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          cran: {
            type: :string,
            only: {
              language: [
                'r'
              ]
            }
          },
          disable_homebrew: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          latex: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          pandoc: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          pandoc_version: {
            type: :string,
            only: {
              language: [
                'r'
              ]
            }
          },
          r_build_args: {
            type: :string,
            only: {
              language: [
                'r'
              ]
            }
          },
          r_check_args: {
            type: :string,
            only: {
              language: [
                'r'
              ]
            }
          },
          r_check_revdep: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          warnings_are_errors: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          },
          remotes: {
            type: :string,
            only: {
              language: [
                'r'
              ]
            }
          },
          repos: {
            type: :object,
            only: {
              language: [
                'r'
              ]
            }
          },
          use_devtools: {
            type: :boolean,
            only: {
              language: [
                'r'
              ]
            }
          }
        },
        normal: true
    )
  end
end
