describe Travis::Yml::Schema::Def::Erlang, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:erlang] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_erlang,
        title: 'Language Erlang',
        type: :object,
        properties: {
          otp_release: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          otp_release: {
            only: {
              language: [
                'erlang'
              ]
            }
          }
        }
      )
    end
  end
end
