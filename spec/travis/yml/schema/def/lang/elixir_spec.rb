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
        normal: true,
        only: {
          elixir: {
            language: [
              'elixir'
            ]
          },
          otp_release: {
            language: [
              'elixir'
            ]
          }
        }
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
