describe Travis::Yml::Schema::Def::Branches, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:branches] }
    # subject { described_class.new.definitions[:type][:branches] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :branches,
        title: 'Branches',
        anyOf: [
          {
            type: :object,
            properties: {
              only: {
                '$ref': '#/definitions/strs'
              },
              except: {
                '$ref': '#/definitions/strs'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: :only,
            aliases: {
              except: [
                :exclude
              ]
            }
          },
          {
            '$ref': '#/definitions/strs'
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/branches'
      )
    end
  end
end
