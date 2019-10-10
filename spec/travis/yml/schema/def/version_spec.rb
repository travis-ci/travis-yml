describe Travis::Yml::Schema::Def::Version do
  subject { Travis::Yml.schema[:definitions][:type][:version] }

  it do
    should eq(
      '$id': :version,
      title: 'Version',
      summary: 'Build config specification version',
      example: '>= 1.0.0',
      type: :string,
      pattern: '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$'
    )
  end
end
