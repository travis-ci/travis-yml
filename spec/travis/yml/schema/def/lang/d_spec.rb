describe Travis::Yml::Schema::Def::D, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:d] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :d,
        title: 'D',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'd'
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
          d: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'd'
              ]
            }
          },
          d: {
            only: {
              language: [
                'd'
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
        '$ref': '#/definitions/language/d'
      )
    end
  end
end
