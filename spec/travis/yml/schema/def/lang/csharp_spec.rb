describe Travis::Yml::Schema::Def::Csharp, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:csharp] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :csharp,
        title: 'Csharp',
        type: :object,
        properties: {
          dotnet: {
            '$ref': '#/definitions/strs'
          },
          mono: {
            '$ref': '#/definitions/strs'
          },
          solution: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        only: {
          dotnet: {
            language: [
              'csharp'
            ]
          },
          mono: {
            language: [
              'csharp'
            ]
          },
          solution: {
            language: [
              'csharp'
            ]
          }
        }
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/csharp'
      )
    end
  end
end
