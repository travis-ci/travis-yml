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
            '$ref': '#/definitions/strs'
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
