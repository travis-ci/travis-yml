describe Travis::Yml::Schema::Def::NodeJs, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:node_js] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :node_js,
        title: 'Node Js',
        type: :object,
        properties: {
          language: {
            type: :string,
            enum: [
              'node_js'
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
            ],
            values: {
              node_js: {
                aliases: [
                  'javascript'
                ]
              }
            }
          },
          node_js: {
            '$ref': '#/definitions/strs'
          },
          npm_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
          language: {
            only: {
              language: [
                'node_js'
              ]
            }
          },
          node_js: {
            aliases: [
              :node
            ],
            only: {
              language: [
                'node_js'
              ]
            }
          },
          npm_args: {
            only: {
              language: [
                'node_js'
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
        '$ref': '#/definitions/language/node_js'
      )
    end
  end
end
