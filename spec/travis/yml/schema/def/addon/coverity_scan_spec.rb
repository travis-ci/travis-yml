describe Travis::Yml::Schema::Def::Addon::CoverityScan do
  subject { Travis::Yml.schema[:definitions][:addon][:coverity_scan] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :addon_coverity_scan,
      title: 'Addon Coverity Scan',
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
                  prefix: {
                    key: :name
                  },
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
              '$ref': '#/definitions/type/secure'
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
