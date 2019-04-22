describe Travis::Yml::Schema::Def::Erlang, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:erlang] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :erlang,
        title: 'Erlang',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'erlang'
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
          otp_release: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'erlang'
              ]
            }
          },
          otp_release: {
            only: {
              language: [
                'erlang'
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
        '$ref': '#/definitions/language/erlang'
      )
    end
  end
end
