describe Travis::Yml::Schema::Def::Version do
  subject { Travis::Yml.schema[:definitions][:type][:version] }

  it do
    should eq(
      '$id': :version,
      title: 'Version',
      type: :string,
      pattern: '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$'
    )
  end
end
