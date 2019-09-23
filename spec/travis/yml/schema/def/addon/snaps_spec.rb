describe Travis::Yml::Schema::Def::Addon::Snaps do
  subject { Travis::Yml.schema[:definitions][:addon][:snaps] }
  # subject { described_class.new.definitions }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :snaps,
      title: 'Snaps',
      summary: instance_of(String),
      see: instance_of(Hash),
      anyOf: [
        {
          type: :array,
          normal: true,
          items: {
            anyOf: [
              {
                type: :object,
                normal: true,
                properties: {
                  name: {
                    type: :string
                  },
                  classic: {
                    type: :boolean
                  },
                  channel: {
                    type: :string
                  }
                },
                additionalProperties: false,
                prefix: {
                  key: :name
                },
              },
              {
                type: :string
              }
            ]
          },
        },
        {
          type: :object,
          normal: true, # should not actually be normal, right?
          properties: {
            name: {
              type: :string
            },
            classic: {
              type: :boolean
            },
            channel: {
              type: :string
            }
          },
          additionalProperties: false,
          prefix: {
            key: :name
          },
        },
        {
          type: :string
        }
      ]
    )
  end
end
