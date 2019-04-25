describe Travis::Yml::Schema::Def::Rust, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:rust] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_rust,
        title: 'Language Rust',
        type: :object,
        properties: {
          rust: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          rust: {
            only: {
              language: [
                'rust'
              ]
            }
          }
        }
      )
    end
  end
end
