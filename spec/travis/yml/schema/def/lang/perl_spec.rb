describe Travis::Yml::Schema::Def::Perl do
  subject { Travis::Yml.schema[:definitions][:language][:perl] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :perl,
        title: 'Perl',
        type: :object,
        properties: {
          perl: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'perl'
              ]
            }
          }
        },
        normal: true
    )
  end
end
