describe Travis::Yml::Schema::Def::Android do
  subject { Travis::Yml.schema[:definitions][:language][:android] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :android,
      title: 'Android',
      summary: instance_of(String),
      see: instance_of(Hash),
      type: :object,
      properties: {
        jdk: {
          '$ref': '#/definitions/type/jdks',
          flags: [
            :expand
          ],
          only: {
            language: [
              'android'
            ]
          },
        },
        android: {
          type: :object,
          properties: {
            components: {
              '$ref': '#/definitions/type/strs',
              summary: instance_of(String)
            },
            licenses: {
              '$ref': '#/definitions/type/strs',
              summary: instance_of(String)
            }
          },
          additionalProperties: false,
          only: {
            language: [
              'android'
            ]
          }
        }
      },
      normal: true
    )
  end
end
