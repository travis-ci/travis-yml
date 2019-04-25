describe Travis::Yml::Schema::Def::Groovy, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:groovy] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_groovy,
        title: 'Language Groovy',
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
          }
        },
        normal: true,
        keys: {
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
end
