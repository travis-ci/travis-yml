describe Travis::Yml::Schema::Def::Elixir, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:elixir] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :elixir,
        title: 'Elixir',
        type: :object,
        properties: {
          elixir: {
            '$ref': '#/definitions/strs'
          },
          otp_release: {
            '$ref': '#/definitions/strs'
          }
        },
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
        },
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/elixir'
      )
    end
  end
end
