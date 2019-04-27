describe Travis::Yml::Schema::Def::Addon::Snaps, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:snaps] }
    # subject { described_class.new.definitions }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :addon_snaps,
        title: 'Addon Snaps',
        anyOf: [
          {
            type: :array,
            items: {
              type: :object,
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
            normal: true
          },
          {
            type: :object,
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
            type: :array,
            items: {
              type: :string
            }
          },
          {
            type: :string
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/addon/snaps'
      )
    end
  end
end
