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
          jdk: {
            '$ref': '#/definitions/strs'
          },
          lein: {
            type: :string
          }
        },
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
        },
        normal: true
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
