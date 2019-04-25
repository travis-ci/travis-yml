describe Travis::Yml::Schema::Def::Haskell, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:haskell] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_haskell,
        title: 'Language Haskell',
        type: :object,
        properties: {
          ghc: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          ghc: {
            only: {
              language: [
                'haskell'
              ]
            }
          }
        }
      )
    end
  end
end
