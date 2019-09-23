describe Travis::Yml::Schema::Def::Perl do
  subject { Travis::Yml.schema[:definitions][:language][:perl] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :perl,
        title: 'Perl',
        summary: instance_of(String),
        see: instance_of(Hash),
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
