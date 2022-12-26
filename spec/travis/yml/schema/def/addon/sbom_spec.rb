describe Travis::Yml::Schema::Def::Addon::Sbom do
  subject { Travis::Yml.schema[:definitions][:addon][:sbom] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :sbom,
      title: "Sbom",
      anyOf: [
        {
          type: :object,
          properties: {
            on: {
              anyOf: [
                {
                  type: :object,
                  properties: {
                    branch: {
                      '$ref': '#/definitions/type/branches'
                    },
                    condition: {
                      '$ref': '#/definitions/type/strs'
                    },
                    all_branches: {
                      type: :boolean
                    },
                    pr: {
                      type: :boolean
                    }
                  },
                  additionalProperties: false,
                  normal: true,
                  prefix: {
                    key: :branch,
                    only: [
                      :str
                    ]
                  }
                },
                {
                  '$ref': '#/definitions/type/branches'
                }
              ],
              normal: true,
              aliases: [
                :true
              ]
            },
            run_phase: {
              type: :string,
              defaults: [
                {
                  value: :after_success
                }
              ],
              enum: [
                :before_script,
                :script,
                :after_success,
                :after_failure
              ]
            },
            output_format: {
              type: :string,
              defaults: [
                {
                  value: 'cyclonedx-json'
                }
              ],
              enum: [
                'cyclonedx-json',
                'cyclonedx-xml',
                'spdx-json'
              ]
            },
            output_dir: {
              type: :string
            },
            input_di: {
              '$ref': '#/definitions/type/strs'
            }
          },
          additionalProperties: false,
          normal: true,
          changes: [
            {
              change: :enable
            }
          ]
        },
        {
          type: :boolean
        }
      ],
      summary: kind_of(String),
      see: kind_of(Hash),
      normal: true
    )
  end
end
