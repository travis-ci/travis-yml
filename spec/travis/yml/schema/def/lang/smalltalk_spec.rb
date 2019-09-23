describe Travis::Yml::Schema::Def::Smalltalk do
  subject { Travis::Yml.schema[:definitions][:language][:smalltalk] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :smalltalk,
      title: 'Smalltalk',
      summary: instance_of(String),
      see: instance_of(Hash),
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
