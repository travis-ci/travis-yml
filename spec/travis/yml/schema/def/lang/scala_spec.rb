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
            '$ref': '#/definitions/strs'
          },
          jdk: {
            '$ref': '#/definitions/strs'
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
