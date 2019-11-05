describe Travis::Yml::Schema::Def::Git do
  subject { Travis::Yml.schema[:definitions][:type][:git] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :git,
      title: 'Git',
      summary: instance_of(String),
      description: instance_of(String),
      see: instance_of(Hash),
      type: :object,
      properties: {
        autocrlf: {
          anyOf: [
            {
              type: :boolean,
              enum: [
                true,
                false,
                'input'
              ]
            },
            {
              type: :string,
              enum: [
                true,
                false,
                'input'
              ]
            }
          ],
          summary: instance_of(String),
        },
        strategy: {
          type: :string,
          enum: [
            'clone',
            'tarball'
          ],
          summary: instance_of(String),
        },
        quiet: {
          type: :boolean,
          summary: instance_of(String),
        },
        depth: {
          anyOf: [
            {
              type: :number
            },
            {
              type: :boolean
            }
          ],
          summary: instance_of(String),
        },
        lfs_skip_smudge: {
          type: :boolean,
          summary: instance_of(String),
        },
        sparse_checkout: {
          type: :string,
          summary: instance_of(String),
        },
        submodules: {
          type: :boolean,
          summary: instance_of(String),
        },
        submodules_depth: {
          type: :number,
          summary: instance_of(String),
        }
      },
      additionalProperties: false
    )
  end
end
