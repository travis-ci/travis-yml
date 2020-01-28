describe Travis::Yml::Schema::Def::Cache do
  subject { Travis::Yml.schema[:definitions][:type][:cache] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :cache,
      title: 'Cache',
      summary: instance_of(String),
      description: instance_of(String),
      see: instance_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            apt: {
              type: :boolean,
              summary: instance_of(String),
            },
            bundler: {
              type: :boolean,
              summary: instance_of(String),
            },
            cargo: {
              type: :boolean,
              summary: instance_of(String),
            },
            ccache: {
              type: :boolean,
              summary: instance_of(String),
            },
            cocoapods: {
              type: :boolean,
              summary: instance_of(String),
            },
            npm: {
              type: :boolean,
              summary: instance_of(String),
            },
            packages: {
              type: :boolean,
              summary: instance_of(String),
            },
            pip: {
              type: :boolean,
              summary: instance_of(String),
            },
            shards: {
              type: :boolean,
              summary: instance_of(String),
            },
            yarn: {
              type: :boolean,
              summary: instance_of(String),
            },
            directories: {
              '$ref': '#/definitions/type/strs',
              summary: instance_of(String),
              example: './path'
            },
            edge: {
              type: :boolean,
              summary: instance_of(String),
            },
            timeout: {
              type: :number,
              summary: instance_of(String),
              defaults: [
                {
                  value: 3
                }
              ]
            },
            branch: {
              type: :string
            }
          },
          additionalProperties: false,
          normal: true,
          changes: [
            {
              change: :cache
            }
          ]
        },
        {
          type: :boolean,
          enum: [
            false
          ],
          normal: true
        }
      ]
    )
  end
end
