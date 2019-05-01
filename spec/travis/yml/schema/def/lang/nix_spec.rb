describe Travis::Yml::Schema::Def::Nix, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:nix] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_nix,
        title: 'Language Nix',
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
