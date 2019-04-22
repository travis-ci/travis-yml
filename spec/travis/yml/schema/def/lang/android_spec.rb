describe Travis::Yml::Schema::Def::Android, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:android] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :android,
        title: 'Android',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'android'
            ],
            downcase: true,
            defaults: [
              {
                value: 'ruby',
                only: {
                  os: [
                    'linux',
                    'windows'
                  ]
                }
              },
              {
                value: 'objective-c',
                only: {
                  os: [
                    'osx'
                  ]
                }
              }
            ]
          },
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
          language: {
            only: {
              language: [
                'android'
              ]
            }
          },
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/android'
      )
    end
  end
end
