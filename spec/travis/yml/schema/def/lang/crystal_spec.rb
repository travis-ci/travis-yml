describe Travis::Yml::Schema::Def::Crystal, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:crystal] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_crystal,
        title: 'Language Crystal',
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
