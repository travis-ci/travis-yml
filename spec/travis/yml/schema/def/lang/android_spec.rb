describe Travis::Yml::Schema::Def::Android, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:android] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_android,
        title: 'Language Android',
        type: :object,
        properties: {
          jdk: {
            anyOf: [
              {
                type: :array,
                items: {
                  type: :string
                },
                flags: [
                  :expand
                ],
                normal: true
              },
              {
                type: :string
              }
            ],
            flags: [
              :expand
            ]
          },
          android: {
            type: :object,
            properties: {
              components: {
                '$ref': '#/definitions/type/strs'
              },
              licenses: {
                '$ref': '#/definitions/type/strs'
              }
            },
            additionalProperties: false
          }
        },
        normal: true,
        keys: {
          jdk: {
            only: {
              language: [
                'android'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          android: {
            only: {
              language: [
                'android'
              ]
            }
          }
        }
      )
    end
  end
end
