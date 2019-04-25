describe Travis::Yml::Schema::Def::Elm, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:elm] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_elm,
        title: 'Language Elm',
        type: :object,
        properties: {
          elm: {
            '$ref': '#/definitions/type/strs'
          },
          node_js: {
            '$ref': '#/definitions/type/strs'
          },
          elm_format: {
            type: :string
          },
          elm_test: {
            type: :string
          }
        },
        normal: true,
        keys: {
          elm: {
            only: {
              language: [
                'elm'
              ]
            }
          },
          node_js: {
            only: {
              language: [
                'elm'
              ]
            }
          },
          elm_format: {
            only: {
              language: [
                'elm'
              ]
            }
          },
          elm_test: {
            only: {
              language: [
                'elm'
              ]
            }
          }
        }
      )
    end
  end
end
