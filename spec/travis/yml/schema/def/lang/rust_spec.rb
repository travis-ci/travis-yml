describe Travis::Yml::Schema::Def::Rust do
  subject { Travis::Yml.schema[:definitions][:language][:rust] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :rust,
        title: 'Rust',
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
