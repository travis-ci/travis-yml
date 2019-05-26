describe Travis::Yml::Schema::Def::Erlang do
  subject { Travis::Yml.schema[:definitions][:language][:erlang] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :erlang,
        title: 'Erlang',
        type: :object,
        properties: {
          otp_release: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'erlang'
              ]
            }
          }
        },
        normal: true
    )
  end
end
