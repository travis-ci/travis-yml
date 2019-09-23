describe Travis::Yml::Schema::Def::Dart do
  subject { Travis::Yml.schema[:definitions][:language][:dart] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :dart,
        title: 'Dart',
        summary: instance_of(String),
        see: instance_of(Hash),
        type: :object,
        properties: {
          dart: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'dart'
              ]
            }
          },
          dart_task: {
            anyOf: [
              {
                type: :array,
                items: {
                  anyOf: [
                    {
                      type: :object,
                      properties: {
                        test: {
                          type: :string
                        },
                        dartanalyzer: {
                          type: :string
                        },
                        dartfmt: {
                          type: :boolean
                        },
                        install_dartium: {
                          type: :boolean
                        },
                        xvfb: {
                          type: :boolean
                        }
                      },
                      additionalProperties: false
                    },
                    {
                      type: :string
                    }
                  ]
                },
                normal: true
              },
              {
                type: :object,
                properties: {
                  test: {
                    type: :string
                  },
                  dartanalyzer: {
                    type: :string
                  },
                  dartfmt: {
                    type: :boolean
                  },
                  install_dartium: {
                    type: :boolean
                  },
                  xvfb: {
                    type: :boolean
                  }
                },
                additionalProperties: false
              },
              {
                type: :string
              }
            ],
            flags: [
              :expand
            ],
            only: {
              language: [
                'dart'
              ]
            }
          },
          with_content_shell: {
            type: :boolean,
            only: {
              language: [
                'dart'
              ]
            }
          }
        },
        normal: true
    )
  end
end
