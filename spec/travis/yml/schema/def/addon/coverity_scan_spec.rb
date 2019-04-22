describe Travis::Yml::Schema::Def::Addon::CoverityScan, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:coverity_scan] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :coverity_scan,
        title: 'Coverity Scan',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              project: {
                anyOf: [
                  {
                    type: :object,
                    properties: {
                      name: {
                        type: :string
                      },
                      version: {
                        type: :string
                      },
                      description: {
                        type: :string
                      }
                    },
                    additionalProperties: false,
                    prefix: :name,
                    required: [
                      :name
                    ],
                    normal: true
                  },
                  {
                    type: :string
                  }
                ]
              },
              build_script_url: {
                type: :string
              },
              branch_pattern: {
                type: :string
              },
              notification_email: {
                type: :string
              },
              build_command: {
                type: :string
              },
              build_command_prepend: {
                type: :string
              }
            },
            additionalProperties: false,
            changes: [
              {
                change: :enable
              }
            ],
            normal: true
          },
          {
            type: :boolean
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/addon/coverity_scan'
      )
    end
  end
end
