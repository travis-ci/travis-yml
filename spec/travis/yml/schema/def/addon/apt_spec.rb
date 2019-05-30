describe Travis::Yml::Schema::Def::Addon::Apt do
  subject { except(Travis::Yml.schema[:definitions][:addon][:apt], :description) }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :apt,
      title: 'Apt',
      summary: 'Install APT packages and sources',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            packages: {
              '$ref': '#/definitions/type/strs',
              summary: 'Package names',
              example: 'cmake',
              aliases: [
                :package
              ]
            },
            sources: {
              summary: 'Package sources',
              example: 'ubuntu-toolchain-r-test',
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
                            type: :string,
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
              ],
            },
            dist: {
              type: :string,
              summary: 'Distribution'
            },
            update: {
              type: :boolean,
              summary: 'Whether to run apt-get update'
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
          example: 'cmake'
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
