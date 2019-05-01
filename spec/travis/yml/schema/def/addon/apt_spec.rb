describe Travis::Yml::Schema::Def::Addon::Apt do
  subject { Travis::Yml.schema[:definitions][:addon][:apt] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :addon_apt,
      title: 'Addon Apt',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            packages: {
              '$ref': '#/definitions/type/strs',
              aliases: [
                :package
              ]
            },
            sources: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    anyOf: [
                      {
                        type: :object,
                        normal: true,
                        properties: {
                          name: {
                            type: :string
                          },
                          sourceline: {
                            type: :string
                          },
                          key_url: {
                            type: :string
                          }
                        },
                        additionalProperties: false,
                        prefix: {
                          key: :name
                        }
                      },
                      {
                        type: :string
                      }
                    ]
                  },
                  aliases: [
                    :source
                  ],
                  normal: true
                },
                {
                  type: :object,
                  normal: true, # shouldn't be normal
                  properties: {
                    name: {
                      type: :string
                    },
                    sourceline: {
                      type: :string
                    },
                    key_url: {
                      type: :string
                    }
                  },
                  additionalProperties: false,
                  prefix: {
                    key: :name
                  }
                },
                {
                  type: :string
                }
              ],
              aliases: [
                :source
              ]
            },
            dist: {
              type: :string
            },
            update: {
              type: :boolean
            }
          },
          additionalProperties: false,
          prefix: {
            key: :packages
          },
          normal: true,
          changes: [
            {
              change: :enable
            }
          ],
        },
        {
          '$ref': '#/definitions/type/strs',
          aliases: [
            :package
          ]
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
