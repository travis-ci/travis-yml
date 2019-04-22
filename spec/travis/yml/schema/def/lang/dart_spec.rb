describe Travis::Yml::Schema::Def::Dart, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:dart] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :dart,
        title: 'Dart',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'dart'
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
          dart: {
            '$ref': '#/definitions/strs'
          },
          with_content_shell: {
            type: :boolean
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'dart'
              ]
            }
          },
          dart: {
            only: {
              language: [
                'dart'
              ]
            }
          },
          with_content_shell: {
            only: {
              language: [
                'dart'
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
        '$ref': '#/definitions/language/dart'
      )
    end
  end
end
