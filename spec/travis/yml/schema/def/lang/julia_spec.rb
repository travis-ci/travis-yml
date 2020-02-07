describe Travis::Yml::Schema::Def::Julia do
  subject { Travis::Yml.schema[:definitions][:language][:julia] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :julia,
        title: 'Julia',
        summary: kind_of(String),
        see: kind_of(Hash),
        type: :object,
        properties: {
          julia: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'julia'
              ]
            }
          }
        },
        normal: true
    )
  end
end
