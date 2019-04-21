describe Travis::Yml::Schema::Def::Addon::Snaps, 'structure' do
  describe 'definitions' do
    # subject { Travis::Yml.schema[:definitions][:addon][:snaps] }
    subject { described_class.new.definitions }

    # it { puts JSON.pretty_generate(subject) }

    it do
      subject
      next
      should eq(
        '$id': :snaps,
        title: 'Snaps',
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
              normal: true,
              prefix: :name,
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
            prefix: :name,
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
