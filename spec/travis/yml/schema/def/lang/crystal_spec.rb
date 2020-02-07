describe Travis::Yml::Schema::Def::Crystal do
  subject { Travis::Yml.schema[:definitions][:language][:crystal] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :crystal,
        title: 'Crystal',
        summary: kind_of(String),
        see: kind_of(Hash),
        type: :object,
        properties: {
          crystal: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'crystal'
              ]
            }
          }
        },
        normal: true
    )
  end
end
