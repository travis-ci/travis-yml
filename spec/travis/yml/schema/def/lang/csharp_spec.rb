describe Travis::Yml::Schema::Def::Csharp, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:csharp] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_csharp,
        title: 'Language Csharp',
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
        }
      )
    end
  end
end
