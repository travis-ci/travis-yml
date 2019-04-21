describe Travis::Yml::Schema::Def::Stages, 'structure' do
  describe 'definitions' do
    describe 'stages' do
      subject { Travis::Yml.schema[:definitions][:type][:stages] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :stages,
          title: 'Stages',
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
                name: { type: :string },
                if: { type: :string }
              },
              additionalProperties: false,
              prefix: :name,
              normal: true
            },
            {
              type: :string
            }
          ]
        )
      end
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/stages'
      )
    end
  end
end
