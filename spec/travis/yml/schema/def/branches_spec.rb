describe Travis::Yml::Schema::Def::Branches do
  subject { except(Travis::Yml.schema[:definitions][:type][:branches], :description) }
  # subject { described_class.new.definitions[:type][:branches] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :branches,
      title: 'Branches',
      summary: 'Include or exclude branches from being built',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            only: {
              '$ref': '#/definitions/type/strs',
              summary: 'Branches to include',
              example: 'master'
            },
            except: {
              '$ref': '#/definitions/type/strs',
              summary: 'Branches to exclude',
              example: 'development',
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
          '$ref': '#/definitions/type/strs',
          example: 'master'
        }
      ]
    )
  end
end
