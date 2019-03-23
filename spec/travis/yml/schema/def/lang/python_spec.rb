describe Travis::Yml::Schema::Def::Python, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:python] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :python,
        title: 'Python',
        type: :object,
        properties: {
          python: {
            '$ref': '#/definitions/strs'
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
        only: {
          python: {
            language: [
              'python'
            ]
          },
          virtualenv: {
            language: [
              'python'
            ]
          }
        },
        aliases: {
          virtualenv: [
            :virtual_env
          ]
        }
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/python'
      )
    end
  end
end
