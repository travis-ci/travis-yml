describe Travis::Yml::Schema::Def::Haskell, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:haskell] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :haskell,
        title: 'Haskell',
        type: :object,
        properties: {
          ghc: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        only: {
          ghc: {
            language: [
              'haskell'
            ]
          }
        }
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/language/haskell'
  #     )
  #   end
  # end
end
