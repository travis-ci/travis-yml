describe Travis::Yml::Schema::Def::Elixir, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:elixir] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_elixir,
        title: 'Language Elixir',
        type: :object,
        properties: {
          elixir: {
            '$ref': '#/definitions/strs'
          },
          otp_release: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          elixir: {
            only: {
              language: [
                'elixir'
              ]
            }
          },
          otp_release: {
            only: {
              language: [
                'elixir'
              ]
            }
          }
        }
      )
    end
  end
end
