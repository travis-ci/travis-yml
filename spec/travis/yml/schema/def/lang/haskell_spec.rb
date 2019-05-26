describe Travis::Yml::Schema::Def::Haskell do
  subject { Travis::Yml.schema[:definitions][:language][:haskell] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :haskell,
        title: 'Haskell',
        type: :object,
        properties: {
          ghc: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'haskell'
              ]
            }
          }
        },
        normal: true
    )
  end
end
