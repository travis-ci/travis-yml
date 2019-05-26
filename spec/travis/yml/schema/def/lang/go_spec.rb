describe Travis::Yml::Schema::Def::Go do
  subject { Travis::Yml.schema[:definitions][:language][:go] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :go,
        title: 'Go',
        type: :object,
        properties: {
          go: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'go'
              ]
            }
          },
          gobuild_args: {
            type: :string,
            only: {
              language: [
                'go'
              ]
            }
          },
          go_import_path: {
            type: :string,
            only: {
              language: [
                'go'
              ]
            }
          },
          gimme_config: {
            type: :object,
            properties: {
              url: {
                type: :string
              },
              force_reinstall: {
                type: :boolean
              }
            },
            additionalProperties: false,
            only: {
              language: [
                'go'
              ]
            }
          }
        },
        normal: true
    )
  end
end
