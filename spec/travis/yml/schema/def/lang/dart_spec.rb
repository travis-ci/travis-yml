describe Travis::Yml::Schema::Def::Dart, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:dart] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_dart,
        title: 'Language Dart',
        type: :object,
        properties: {
          dart: {
            '$ref': '#/definitions/strs'
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
                }
              }
            ],
            flags: [
              :expand
            ]
          },
          with_content_shell: {
            type: :boolean
          }
        },
        normal: true,
        keys: {
          dart: {
            only: {
              language: [
                'dart'
              ]
            }
          },
          dart_task: {
            only: {
              language: [
                'dart'
              ]
            }
          },
          with_content_shell: {
            only: {
              language: [
                'dart'
              ]
            }
          }
        }
      )
    end
  end
end
