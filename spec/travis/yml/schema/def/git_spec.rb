describe Travis::Yml::Schema::Def::Git do
  subject { Travis::Yml.schema[:definitions][:type][:git] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :git,
      title: 'Git',
      type: :object,
      properties: {
        strategy: {
          type: :string,
          enum: [
            'clone',
            'tarball'
          ]
        },
        quiet: {
          type: :boolean
        },
        depth: {
          anyOf: [
            {
              type: :number
            },
            {
              type: :boolean
            }
          ]
        },
        lfs_skip_smudge: {
          type: :boolean
        },
        sparse_checkout: {
          type: :string
        },
        submodules: {
          type: :boolean
        },
        submodules_depth: {
          type: :number
        }
      },
      additionalProperties: false
    )
  end
end
