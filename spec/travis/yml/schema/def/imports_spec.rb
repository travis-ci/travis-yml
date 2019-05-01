describe Travis::Yml::Schema::Def::Imports do
  describe 'imports' do
    subject { Travis::Yml.schema[:definitions][:type][:imports] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :imports,
        title: 'Imports',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/import'
            },
            normal: true
          },
          {
            '$ref': '#/definitions/type/import'
          }
        ]
      )
    end
  end

  describe 'import' do
    subject { Travis::Yml.schema[:definitions][:type][:import] }

    it do
      should eq(
        '$id': :import,
        title: 'Import',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              source: { type: :string },
              mode: { type: :string, enum: ['merge', 'deep_merge'] }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :source
            },
          },
          {
            type: :string
          }
        ]
      )
    end
  end
end
