describe Travis::Yml::Schema::Def::Cache do
  subject { Travis::Yml.schema[:definitions][:type][:cache] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :cache,
      title: 'Cache',
      summary: 'Cache settings to speed up the build',
      anyOf: [
        {
          type: :object,
          properties: {
            apt: {
              type: :boolean
            },
            bundler: {
              type: :boolean
            },
            cargo: {
              type: :boolean
            },
            ccache: {
              type: :boolean
            },
            cocoapods: {
              type: :boolean
            },
            npm: {
              type: :boolean
            },
            packages: {
              type: :boolean
            },
            pip: {
              type: :boolean
            },
            yarn: {
              type: :boolean
            },
            edge: {
              summary: 'Whether to use an edge version of the cache tooling',
              type: :boolean
            },
            directories: {
              '$ref': '#/definitions/type/strs',
              example: './path'
            },
            timeout: {
              type: :number
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
