describe Travis::Yml::Schema::Def::Java, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:java] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_java,
        title: 'Language Java',
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
end
