describe Travis::Yml::Schema::Def::Rust do
  subject { Travis::Yml.schema[:definitions][:language][:rust] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :rust,
        title: 'Rust',
        summary: kind_of(String),
        see: kind_of(Hash),
        type: :object,
        properties: {
          rust: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'rust'
              ]
            }
          }
        },
        normal: true
    )
  end
end
