describe Travis::Yml::Schema::Def::Julia, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:julia] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :julia,
        title: 'Julia',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'julia'
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
          julia: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'julia'
              ]
            }
          },
          julia: {
            only: {
              language: [
                'julia'
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
        '$ref': '#/definitions/language/julia'
      )
    end
  end
end
