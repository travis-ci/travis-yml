describe Travis::Yml::Schema::Def::Git do
  subject { Travis::Yml.schema[:definitions][:type][:git] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :git,
      title: 'Git',
      summary: kind_of(String),
      description: kind_of(String),
      see: kind_of(Hash),
      type: :object,
      properties: {
        autocrlf: {
          anyOf: [
            {
              type: :boolean,
              enum: [
                true,
                false
              ]
            },
            {
              type: :string,
              enum: [
                'input'
              ]
            }
          ],
          summary: kind_of(String),
        },
        strategy: {
          type: :string,
          enum: [
            'clone',
            'tarball'
          ],
          summary: kind_of(String),
        },
        quiet: {
          type: :boolean,
          summary: kind_of(String),
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
          summary: kind_of(String),
        },
        lfs_skip_smudge: {
          type: :boolean,
          summary: kind_of(String),
        },
        sparse_checkout: {
          type: :string,
          summary: kind_of(String),
        },
        submodules: {
          type: :boolean,
          summary: kind_of(String),
        },
        submodules_depth: {
          type: :number,
          summary: kind_of(String),
        },
        symlinks: {
          type: :boolean,
          summary: kind_of(String),
        },
      },
      additionalProperties: false
    )
  end
end
