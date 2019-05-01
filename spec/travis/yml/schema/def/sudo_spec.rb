describe Travis::Yml::Schema::Def::Sudo do
  subject { Travis::Yml.schema[:definitions][:type][:sudo] }

  it do
    should eq(
      '$id': :sudo,
      title: 'Sudo',
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
