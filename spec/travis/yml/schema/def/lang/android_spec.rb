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
            '$ref': '#/definitions/strs'
          },
          android: {
            type: :object,
            properties: {
              components: {
                '$ref': '#/definitions/strs'
              },
              licenses: {
                '$ref': '#/definitions/strs'
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
