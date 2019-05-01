describe Travis::Yml::Schema::Def::D, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:d] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_d,
        title: 'Language D',
        type: :object,
        properties: {
          d: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'd'
              ]
            }
          }
        },
        normal: true
    )
  end
end
