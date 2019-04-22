describe Travis::Yml::Schema::Def::Archs, 'structure' do
  describe 'definitions' do
    describe 'archs' do
      subject { Travis::Yml.schema[:definitions][:type][:archs] }
      # subject { described_class.new.definitions[:type][:archs] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :archs,
          title: 'Architectures',
          description: 'The architectures that will be selected for the build environments.',
          anyOf: [
            {
              type: :array,
              items: {
                '$ref': '#/definitions/type/arch'
              },
              flags: [
                :expand
              ],
              normal: true,
            },
            {
              '$ref': '#/definitions/type/arch'
            }
          ],
          flags: [
            :expand
          ]
        )
      end
    end

    describe 'arch' do
      subject { Travis::Yml.schema[:definitions][:type][:arch] }

      it do
        should eq(
          '$id': :arch,
          title: 'Architecture',
          description: 'The architecture that will be selected for the build environment.',
          type: :string,
          enum: [
            'amd64',
            'ppc64le',
          ],
          downcase: true,
          values: {
            amd64: {
              aliases: [
                'x86_64'
              ]
            },
            ppc64le: {
              aliases: [
                'power',
                'ppc',
                'ppc64'
              ]
            }
          }
        )
      end
    end
  end

  describe 'schema' do
    subject { described_class.new(nil, export: true).schema }

    it do
      should eq(
        '$ref': '#/definitions/type/archs'
      )
    end
  end
end
