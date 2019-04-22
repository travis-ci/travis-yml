describe Travis::Yml::Schema::Def::Crystal, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:crystal] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :crystal,
        title: 'Crystal',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'crystal'
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
          crystal: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'crystal'
              ]
            }
          },
          crystal: {
            only: {
              language: [
                'crystal'
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
        '$ref': '#/definitions/language/crystal'
      )
    end
  end
end
