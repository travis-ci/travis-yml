describe Travis::Yml::Schema::Def::Cache do
  subject { Travis::Yml.schema[:definitions][:type][:cache] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :cache,
      title: 'Cache',
      summary: kind_of(String),
      description: kind_of(String),
      see: kind_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            apt: {
              type: :boolean,
              summary: kind_of(String),
            },
            bundler: {
              type: :boolean,
              summary: kind_of(String),
            },
            cargo: {
              type: :boolean,
              summary: kind_of(String),
            },
            ccache: {
              type: :boolean,
              summary: kind_of(String),
            },
            cocoapods: {
              type: :boolean,
              summary: kind_of(String),
            },
            npm: {
              type: :boolean,
              summary: kind_of(String),
            },
            packages: {
              type: :boolean,
              summary: kind_of(String),
            },
            pip: {
              type: :boolean,
              summary: kind_of(String),
            },
            shards: {
              type: :boolean,
              summary: instance_of(String),
            },
            yarn: {
              type: :boolean,
              summary: kind_of(String),
            },
            directories: {
              '$ref': '#/definitions/type/strs',
              summary: kind_of(String),
              example: './path'
            },
            edge: {
              type: :boolean,
              summary: kind_of(String),
            },
            timeout: {
              type: :number,
              summary: kind_of(String),
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
