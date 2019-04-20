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
        keys: {
          dotnet: {
            only: {
              language: [
                'csharp'
              ]
            }
          },
          mono: {
            only: {
              language: [
                'csharp'
              ]
            }
          },
          solution: {
            only: {
              language: [
                'csharp'
              ]
            }
          }
        },
        normal: true
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
