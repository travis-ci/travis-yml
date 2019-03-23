describe Travis::Yml::Schema::Def::Version, 'structure' do
  describe 'definitions' do
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/version'
      )
    end
  end
end
