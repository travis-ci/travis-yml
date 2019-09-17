describe Travis::Yml::Schema::Def::Addon::Pkg do
  subject { Travis::Yml.schema[:definitions][:addon][:pkg] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :pkg,
      title: 'Pkg',
      anyOf: [
        {
          type: :object,
          properties: {
            packages: {
              '$ref': '#/definitions/type/strs',
              aliases: [
                :package
              ],
              summary: 'Package names',
              example: 'cmake'
            },
            branch: {
              type: :string,
              summary: 'Packages branch',
              example: 'quarterly'
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
          ]
        },
        {
          '$ref': '#/definitions/type/strs',
          example: 'cmake'
        },
        {
          type: :boolean
        }
      ],
      normal: true,
    )
  end
end
