describe Travis::Yml::Schema::Def::Sudo, 'structure' do
  describe 'definitions' do
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/sudo'
      )
    end
  end
end
