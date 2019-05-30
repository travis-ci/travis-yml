describe Travis::Yml::Schema::Def::Android do
  subject { Travis::Yml.schema[:definitions][:language][:android] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :android,
      title: 'Android',
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
              '$ref': '#/definitions/type/strs'
            },
            licenses: {
              '$ref': '#/definitions/type/strs'
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
