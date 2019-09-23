describe Travis::Yml::Schema::Def::Stages do
  describe 'stages' do
    subject { Travis::Yml.schema[:definitions][:type][:stages] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :stages,
        title: 'Stages',
        summary: 'Build stages definition',
        description: instance_of(String),
        see: instance_of(Hash),
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/stage'
            },
            normal: true
          },
          {
            '$ref': '#/definitions/type/stage'
          }
        ]
      )
    end
  end

  describe 'stage' do
    subject { Travis::Yml.schema[:definitions][:type][:stage] }

    it do
      should eq(
        '$id': :stage,
        title: 'Stage',
        anyOf: [
          {
            type: :object,
            properties: {
              name: {
                type: :string,
                summary: 'The name of the stage',
                example: 'unit tests'
              },
              if: {
                '$ref': '#/definitions/type/condition',
              }
            },
            additionalProperties: false,
            prefix: {
              key: :name
            },
            normal: true
          },
          {
            type: :string,
            example: 'unit tests'
          }
        ]
      )
    end
  end
end
