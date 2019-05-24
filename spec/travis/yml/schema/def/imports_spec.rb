describe Travis::Yml::Schema::Def::Imports do
  describe 'imports' do
    subject { Travis::Yml.schema[:definitions][:type][:imports] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :imports,
        title: 'Imports',
        description: "Import YAML config snippets that can be shared across repositories.\n\nSee [the docs](...) for details.",
        summary: 'Build configuration imports',
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
                example: 'other/repo/import.yml@v1'
              },
              mode: {
                type: :string,
                enum: ['merge', 'deep_merge'],
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
            example: 'other/repo/import.yml@v1'
          }
        ]
      )
    end
  end
end
