describe Travis::Yml::Schema::Def::Scala, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:scala] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :scala,
        title: 'Scala',
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
        },
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/scala'
      )
    end
  end
end
