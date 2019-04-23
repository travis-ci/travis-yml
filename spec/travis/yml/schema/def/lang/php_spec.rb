describe Travis::Yml::Schema::Def::Php, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:php] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_php,
        title: 'Language Php',
        type: :object,
        properties: {
          php: {
            '$ref': '#/definitions/strs'
          },
          composer_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
          php: {
            only: {
              language: [
                'php'
              ]
            }
          },
          composer_args: {
            only: {
              language: [
                'php'
              ]
            }
          }
        }
      )
    end
  end
end
