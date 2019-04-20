describe Travis::Yml::Schema::Def::Elm, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:elm] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :elm,
        title: 'Elm',
        type: :object,
        properties: {
          elm: {
            '$ref': '#/definitions/strs'
          },
          elm_format: {
            type: :string
          },
          elm_test: {
            type: :string
          }
        },
        keys: {
          elm: {
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
        },
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/elm'
      )
    end
  end
end
