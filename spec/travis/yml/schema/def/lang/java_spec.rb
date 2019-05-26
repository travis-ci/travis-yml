describe Travis::Yml::Schema::Def::Java do
  subject { Travis::Yml.schema[:definitions][:language][:java] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :java,
        title: 'Java',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/type/jdks',
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
        },
        normal: true
    )
  end
end
