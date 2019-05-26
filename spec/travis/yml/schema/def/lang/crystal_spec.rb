describe Travis::Yml::Schema::Def::Crystal do
  subject { Travis::Yml.schema[:definitions][:language][:crystal] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :crystal,
        title: 'Crystal',
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
