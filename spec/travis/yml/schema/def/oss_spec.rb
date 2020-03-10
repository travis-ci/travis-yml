describe Travis::Yml::Schema::Def::Oss do
  describe 'oss' do
    subject { Travis::Yml.schema[:definitions][:type][:oss] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :oss,
        title: 'Operating systems',
        summary: 'Build environment operating systems',
        see: kind_of(Hash),
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/os'
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/os'
          }
        ],
      )
    end
  end

  describe 'os' do
    subject { Travis::Yml.schema[:definitions][:type][:os] }

    it do
      should eq(
        '$id': :os,
        title: 'Os',
        type: :string,
        enum: [
          'linux',
          'osx',
          'windows',
          'freebsd',
          'linux-ppc64le'
        ],
        defaults: [
          {
            value: 'linux',
            except: {
              language: [
                'objective-c'
              ]
            }
          },
          {
            value: 'osx'
          },
          {
            value: 'windows',
            except: {
              language: [
                'objective-c'
              ]
            }
          },
          {
            value: 'freebsd',
            except: {
              language: [
                'objective-c'
              ]
            }
          },
        ],
        downcase: true,
        values: {
          linux: {
            aliases: [
              'ubuntu'
            ],
            except: {
              language: [
                'objective-c'
              ]
            }
          },
          # 'linux-ppc64le': {
          #   deprecated: 'use os: linux, arch: ppc64le'
          # },
          osx: {
            aliases: [
              'mac',
              'macos',
              'macosx',
              'ios'
            ],
          },
          freebsd: {
            aliases: [
              'bsd'
            ],
            except: {
              language: [
                'objective-c'
              ]
            }
          },
          windows: {
            aliases: [
              'win'
            ],
            except: {
              language: [
                'objective-c'
              ]
            }
          },
        }
      )
    end
  end
end
