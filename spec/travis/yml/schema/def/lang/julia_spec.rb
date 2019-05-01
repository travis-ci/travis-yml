describe Travis::Yml::Schema::Def::Julia, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:julia] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_julia,
        title: 'Language Julia',
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
