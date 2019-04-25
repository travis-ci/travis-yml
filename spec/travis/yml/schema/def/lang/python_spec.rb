describe Travis::Yml::Schema::Def::Python, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:python] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_python,
        title: 'Language Python',
        type: :object,
        properties: {
          python: {
            '$ref': '#/definitions/type/strs'
          },
          virtualenv: {
            type: :object,
            properties: {
              system_site_packages: {
                type: :boolean
              }
            }
          }
        },
        normal: true,
        keys: {
          python: {
            only: {
              language: [
                'python'
              ]
            }
          },
          virtualenv: {
            aliases: [
              :virtual_env
            ],
            only: {
              language: [
                'python'
              ]
            }
          }
        }
      )
    end
  end
end
