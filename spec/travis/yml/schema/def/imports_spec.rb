describe Travis::Yml::Schema::Def::Imports do
  describe 'imports' do
    subject { Travis::Yml.schema[:definitions][:type][:imports] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :imports,
        title: 'Imports',
        summary: instance_of(String),
        description: instance_of(String),
        # see: instance_of(Hash),
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
              source: {
                type: :string,
                summary: 'The source to import build config from',
                example: './import.yml@v1'
              },
              mode: {
                type: :string,
                enum: ['merge', 'deep_merge', 'deep_merge_append', 'deep_merge_prepend'],
                summary: 'How to merge the imported config into the target config'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :source
            },
          },
          {
            type: :string,
            example: './import.yml@v1'
          }
        ]
      )
    end
  end
end
