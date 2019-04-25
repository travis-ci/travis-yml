describe Travis::Yml::Schema::Def::Crystal, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:crystal] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_crystal,
        title: 'Language Crystal',
        type: :object,
        properties: {
          crystal: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          crystal: {
            only: {
              language: [
                'crystal'
              ]
            }
          }
        }
      )
    end
  end
end
