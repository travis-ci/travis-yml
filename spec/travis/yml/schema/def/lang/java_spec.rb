describe Travis::Yml::Schema::Def::Java, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:java] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :java,
        title: 'Java',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'java'
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
            ],
            values: {
              java: {
                aliases: [
                  'jvm'
                ]
              }
            }
          },
          jdk: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'java'
              ]
            }
          },
          jdk: {
            only: {
              language: [
                'java'
              ]
            },
            except: {
              os: [
                'osx'
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
        '$ref': '#/definitions/language/java'
      )
    end
  end
end
