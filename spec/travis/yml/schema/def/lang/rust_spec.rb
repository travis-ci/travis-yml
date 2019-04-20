describe Travis::Yml::Schema::Def::Rust, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:rust] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :rust,
        title: 'Rust',
        type: :object,
        properties: {
          rust: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        only: {
          rust: {
            language: [
              'rust'
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
  #       '$ref': '#/definitions/language/rust'
  #     )
  #   end
  # end
end
