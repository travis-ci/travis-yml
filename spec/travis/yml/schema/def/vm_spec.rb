describe Travis::Yml::Schema::Def::VM do
  subject { Travis::Yml.schema[:definitions][:type][:vm] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :vm,
      title: 'Vm',
      summary: "VM size and custom image settings",
      description: "These settings can be used in order to choose VM size and custom image",
      see: {
        "Customizing the Build": "https://docs.travis-ci.com/user/customizing-the-build/"
      },
      type: :object,
      properties: {
        create: {
          additionalProperties: false,
          example: "my_custom_name",
          flags: [
            :unique_value_globally
          ],
          properties: {
            name: {
              type: :string
            }
          },
          summary: "The name of the custom image to create",
          type: :object
        },
        size: {
          type: :string,
          enum: [
            'medium',
            'large',
            'x-large',
            '2x-large',
            'gpu-medium',
            'gpu-xlarge'
          ]
        },
        use: {
          anyOf: [
            {
              additionalProperties: false,
              example: "my_custom_name",
              properties: {
                name: {
                  type: :string
                }
              },
              summary: "The name of the custom image to use",
              type: :object
            },
            {
              type: :string
            }
          ]
        }
      },
      additionalProperties: false
    )
  end
end
