describe Travis::Yml::Schema::Def::Csharp do
  subject { Travis::Yml.schema[:definitions][:language][:csharp] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :csharp,
      title: 'C#',
      summary: instance_of(String),
      see: instance_of(Hash),
      type: :object,
      properties: {
        dotnet: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'csharp'
            ]
          }
        },
        mono: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'csharp'
            ]
          }
        },
        solution: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
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
