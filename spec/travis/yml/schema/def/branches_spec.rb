describe Travis::Yml::Schema::Def::Branches do
  subject { Travis::Yml.schema[:definitions][:type][:branches] }
  # subject { described_class.new.definitions[:type][:branches] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :branches,
      title: 'Branches',
      description: 'The branches your build will be run on.',
      normal: true,
      aliases: [
        :branch
      ],
      anyOf: [
        {
          type: :object,
          properties: {
            only: {
              '$ref': '#/definitions/type/strs'
            },
            except: {
              '$ref': '#/definitions/type/strs',
              aliases: [
                :exclude
              ]
            }
          },
          additionalProperties: false,
          normal: true,
          prefix: {
            key: :only
          },
          aliases: [
            :branch
          ]
        },
        {
          '$ref': '#/definitions/type/strs'
        }
      ]
    )
  end
end
