describe Travis::Yml::Schema::Def::Sudo do
  subject { Travis::Yml.schema[:definitions][:type][:sudo] }

  it do
    should include(
      '$id': :sudo,
      title: 'Sudo',
      summary: 'Whether to allow sudo access',
      example: 'required',
      deprecated: kind_of(String),
      anyOf: [
        {
          type: :boolean,
          normal: true
        },
        {
          type: :string
        }
      ]
    )
  end
end
