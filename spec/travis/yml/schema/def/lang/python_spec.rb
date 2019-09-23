describe Travis::Yml::Schema::Def::Python do
  subject { Travis::Yml.schema[:definitions][:language][:python] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :python,
        title: 'Python',
        summary: instance_of(String),
        see: instance_of(Hash),
        type: :object,
        properties: {
          python: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'python'
              ]
            }
          },
          virtualenv: {
            type: :object,
            properties: {
              system_site_packages: {
                type: :boolean
              }
            },
            only: {
              language: [
                'python'
              ]
            },
            aliases: [
              :virtual_env
            ]
          }
        },
        normal: true
    )
  end
end
