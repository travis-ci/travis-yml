describe Travis::Yml::Schema::Def::Clojure do
  subject { Travis::Yml.schema[:definitions][:language][:clojure] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :clojure,
        title: 'Clojure',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/type/jdks',
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
            type: :string,
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
