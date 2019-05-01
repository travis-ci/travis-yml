describe Travis::Yml::Schema::Def::Java, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:java] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_java,
        title: 'Language Java',
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
