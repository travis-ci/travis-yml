describe Travis::Yml::Schema::Def::Perl, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:perl] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :perl,
        title: 'Perl',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'perl'
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
          perl: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'perl'
              ]
            }
          },
          perl: {
            only: {
              language: [
                'perl'
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
        '$ref': '#/definitions/language/perl'
      )
    end
  end
end
