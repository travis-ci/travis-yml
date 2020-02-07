describe Travis::Yml::Schema::Def::Scala do
  subject { Travis::Yml.schema[:definitions][:language][:scala] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :scala,
      title: 'Scala',
      summary: kind_of(String),
      see: kind_of(Hash),
      type: :object,
      properties: {
        scala: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'scala'
            ]
          }
        },
        jdk: {
          '$ref': '#/definitions/type/jdks',
          flags: [
            :expand
          ],
          only: {
            language: [
              'scala'
            ]
          },
        },
        sbt_args: {
          type: :string,
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
