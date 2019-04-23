describe Travis::Yml::Schema::Def::Clojure, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:clojure] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_clojure,
        title: 'Language Clojure',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/strs'
          },
          lein: {
            type: :string
          }
        },
        normal: true,
        keys: {
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
end
