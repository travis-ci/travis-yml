describe Travis::Yml::Schema::Def::Sudo do
  subject { Travis::Yml.schema[:definitions][:type][:sudo] }

  it do
    should eq(
      '$id': :sudo,
      title: 'Sudo',
      summary: 'Whether to allow sudo access',
      example: 'required',
      deprecated: 'this key has no effect anymore',
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
