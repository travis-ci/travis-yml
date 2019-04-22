describe Travis::Yml::Schema::Def::Groovy, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:groovy] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :groovy,
        title: 'Groovy',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'groovy'
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
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'groovy'
              ]
            }
          },
          jdk: {
            only: {
              language: [
                'groovy'
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
        '$ref': '#/definitions/language/groovy'
      )
    end
  end
end
