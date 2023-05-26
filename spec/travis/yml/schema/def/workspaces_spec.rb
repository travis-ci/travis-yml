describe Travis::Yml::Schema::Def::Workspaces do
  describe 'workspaces' do
    subject { Travis::Yml.schema[:definitions][:type][:workspaces] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :workspaces,
        title: 'Workspaces',
        summary: kind_of(String),
        description: kind_of(String),
        see: {
          Workspaces: kind_of(String)
        },
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/workspace',
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/workspace',
          }
        ],
      )
    end
  end

  describe 'workspace' do
    subject { Travis::Yml.schema[:definitions][:type][:workspace] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :workspace,
        title: 'Workspace',
        anyOf: [
          {
            type: :object,
            properties: {
              name: {
                type: :string
              },
              create: {
                type: :boolean
              }
            },
            prefix: {
              key: :name
            },
            additionalProperties: false,
            normal: true
          },
          {
            type: :string
          }
        ],
        normal: true
      )
    end
  end
end
