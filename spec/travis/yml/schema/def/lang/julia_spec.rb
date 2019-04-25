describe Travis::Yml::Schema::Def::Julia, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:julia] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_julia,
        title: 'Language Julia',
        type: :object,
        properties: {
          julia: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          julia: {
            only: {
              language: [
                'julia'
              ]
            }
          }
        }
      )
    end
  end
end
