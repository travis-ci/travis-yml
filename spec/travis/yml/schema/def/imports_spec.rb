describe Travis::Yml::Schema::Def::Imports, 'structure' do
  describe 'definitions' do
    describe 'imports' do
      subject { Travis::Yml.schema[:definitions][:type][:imports] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :imports,
          title: 'Imports',
          anyOf: [
            {
              type: :array,
              items: {
                '$ref': '#/definitions/type/import'
              },
              normal: true
            },
            {
              '$ref': '#/definitions/type/import'
            }
          ]
        )
      end
    end

    describe 'import' do
      subject { Travis::Yml.schema[:definitions][:type][:import] }

      it do
        should eq(
          '$id': :import,
          title: 'Import',
          anyOf: [
            {
              type: :object,
              properties: {
                source: { type: :string },
                mode: { type: :string, enum: ['merge', 'deep_merge'] }
              },
              additionalProperties: false,
              normal: true,
              prefix: :source,
            },
            {
              type: :string
            }
          ]
        )
      end
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/type/imports'
  #     )
  #   end
  # end
end
