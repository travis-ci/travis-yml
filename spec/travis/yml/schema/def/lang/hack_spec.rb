describe Travis::Yml::Schema::Def::Hack do
  subject { Travis::Yml.schema[:definitions][:language][:hack] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :hack,
      title: 'Hack',
      summary: instance_of(String),
      # see: instance_of(Hash),
      type: :object,
      properties: {
        hhvm: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'hack'
            ]
          }
        },
        php: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'hack'
            ]
          }
        }
      },
      normal: true
    )
  end
end
