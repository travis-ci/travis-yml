describe Travis::Yml::Schema::Def::Php, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:php] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :php,
        title: 'Php',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'php'
            ],
            downcase: true,
            defaults: [
              {
                value: 'ruby',
                only: {
                  os: [
                    'linux',
                    'windows'
                  ]
                }
              },
              {
                value: 'objective-c',
                only: {
                  os: [
                    'osx'
                  ]
                }
              }
            ]
          },
          php: {
            '$ref': '#/definitions/strs'
          },
          composer_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'php'
              ]
            }
          },
          php: {
            only: {
              language: [
                'php'
              ]
            }
          },
          composer_args: {
            only: {
              language: [
                'php'
              ]
            }
          }
        }
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/php'
      )
    end
  end
end
