describe Travis::Yml::Schema::Def::Smalltalk, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:smalltalk] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_smalltalk,
        title: 'Language Smalltalk',
        type: :object,
        properties: {
          smalltalk: {
            '$ref': '#/definitions/type/strs'
          },
          smalltalk_config: {
            '$ref': '#/definitions/type/strs'
          },
          smalltalk_vm: {
            '$ref': '#/definitions/type/strs'
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
            additionalProperties: false
          }
        },
        normal: true,
        keys: {
          smalltalk: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_config: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_vm: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_edge: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          }
        }
      )
    end
  end
end
