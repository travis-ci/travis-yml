describe Travis::Yml::Schema::Def::Clojure, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:clojure] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :clojure,
        title: 'Clojure',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'clojure'
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
          lein: {
            type: :string
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'clojure'
              ]
            }
          },
          jdk: {
            only: {
              language: [
                'clojure'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          lein: {
            only: {
              language: [
                'clojure'
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
        '$ref': '#/definitions/language/clojure'
      )
    end
  end
end
