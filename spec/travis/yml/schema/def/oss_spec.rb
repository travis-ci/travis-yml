describe Travis::Yml::Schema::Def::Oss, 'structure' do
  describe 'definitions' do
    describe 'oss' do
      subject { Travis::Yml.schema[:definitions][:type][:oss] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :oss,
          title: 'Oss',
          anyOf: [
            {
              type: :array,
              items: {
                '$ref': '#/definitions/type/os'
              },
              normal: true,
              flags: [
                :expand
              ]
            },
            {
              '$ref': '#/definitions/type/os'
            }
          ],
          flags: [
            :expand
          ]
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
                  'c',
                  'cpp',
                  'go',
                  'node_js',
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
                  'c',
                  'cpp',
                  'go',
                  'node_js',
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/oss'
      )
    end
  end
end
