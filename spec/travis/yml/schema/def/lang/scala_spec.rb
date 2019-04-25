describe Travis::Yml::Schema::Def::Scala, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:scala] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_scala,
        title: 'Language Scala',
        type: :object,
        properties: {
          scala: {
            '$ref': '#/definitions/type/strs'
          },
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
          },
          sbt_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
          scala: {
            only: {
              language: [
                'scala'
              ]
            }
          },
          jdk: {
            only: {
              language: [
                'scala'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          sbt_args: {
            only: {
              language: [
                'scala'
              ]
            }
          }
        }
      )
    end
  end
end
