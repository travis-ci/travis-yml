describe Travis::Yml::Schema::Def::Branches, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:branches] }
    # subject { described_class.new.definitions[:type][:branches] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :branches,
        title: 'Branches',
        description: 'The branches your build will be run on.',
        anyOf: [
          {
            type: :object,
            properties: {
              only: {
                '$ref': '#/definitions/type/strs'
              },
              except: {
                '$ref': '#/definitions/type/strs'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: :only,
            keys: {
              except: {
                aliases: [
                  :exclude
                ]
              }
            }
          },
          {
            '$ref': '#/definitions/type/strs'
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
