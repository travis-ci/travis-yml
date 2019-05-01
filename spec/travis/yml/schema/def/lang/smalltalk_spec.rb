describe Travis::Yml::Schema::Def::Smalltalk, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:smalltalk] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_smalltalk,
        title: 'Language Smalltalk',
        type: :object,
        properties: {
          smalltalk: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_config: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_vm: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_edge: {
            type: :object,
            properties: {
              source: {
                type: :string
              },
              branch: {
                type: :string
              }
            },
            additionalProperties: false,
            only: {
              language: [
                'smalltalk'
              ]
            }
          }
        },
        normal: true
    )
  end
end
