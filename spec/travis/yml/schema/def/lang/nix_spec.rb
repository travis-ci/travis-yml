describe Travis::Yml::Schema::Def::Nix do
  subject { Travis::Yml.schema[:definitions][:language][:nix] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :nix,
        title: 'Nix',
        type: :object,
        properties: {
          nix: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'nix'
              ]
            }
          }
        },
        normal: true
    )
  end
end
