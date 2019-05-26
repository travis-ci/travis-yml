describe Travis::Yml::Schema::Def::Groovy do
  subject { Travis::Yml.schema[:definitions][:language][:groovy] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :groovy,
        title: 'Groovy',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/type/jdks',
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
        },
        normal: true
    )
  end
end
