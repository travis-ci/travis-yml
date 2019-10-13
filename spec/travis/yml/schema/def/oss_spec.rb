describe Travis::Yml::Schema::Def::Oss do
  describe 'oss' do
    subject { Travis::Yml.schema[:definitions][:type][:oss] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :oss,
        title: 'Operating systems',
        summary: 'Build environment operating systems',
        see: instance_of(Hash),
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
          'windows'
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
            value: 'osx',
            except: {
              language: [
                'php',
                'perl',
                'erlang',
                'groovy',
                'clojure',
                'scala',
                'haskell'
              ]
            }
          },
          {
            value: 'windows',
            only: {
              language: [
                'csharp',
                'go',
                'node_js',
                'powershell',
                'rust',
                'shell',
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
          osx: {
            aliases: [
              'mac',
              'macos',
              'macosx',
              'ios'
            ],
            except: {
              language: [
                'php',
                'perl',
                'erlang',
                'groovy',
                'clojure',
                'scala',
                'haskell',
              ]
            }
          },
          windows: {
            aliases: [
              'win'
            ],
            only: {
              language: [
                'csharp',
                'go',
                'node_js',
                'powershell',
                'rust',
                'shell',
              ]
            }
          },
        }
      )
    end
  end
end
