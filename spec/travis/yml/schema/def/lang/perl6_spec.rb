describe Travis::Yml::Schema::Def::Perl6 do
  subject { Travis::Yml.schema[:definitions][:language][:perl6] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :perl6,
        title: 'Perl6',
        type: :object,
        properties: {
          perl6: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'perl6'
              ]
            }
          }
        },
        normal: true
    )
  end
end
