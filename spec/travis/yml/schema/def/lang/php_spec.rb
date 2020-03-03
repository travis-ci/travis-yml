describe Travis::Yml::Schema::Def::Php do
  subject { Travis::Yml.schema[:definitions][:language][:php] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :php,
      title: 'PHP',
      summary: kind_of(String),
      see: kind_of(Hash),
      type: :object,
      properties: {
        php: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'php'
            ]
          }
        },
        composer_args: {
          type: :string,
          only: {
            language: [
              'php'
            ]
          }
        }
      },
      normal: true
    )
  end
end
