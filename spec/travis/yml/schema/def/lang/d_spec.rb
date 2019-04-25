describe Travis::Yml::Schema::Def::D, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:d] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_d,
        title: 'Language D',
        type: :object,
        properties: {
          d: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          d: {
            only: {
              language: [
                'd'
              ]
            }
          }
        }
      )
    end
  end
end
