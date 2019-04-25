describe Travis::Yml::Schema::Def::NodeJs, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:node_js] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_node_js,
        title: 'Language Node Js',
        type: :object,
        properties: {
          node_js: {
            '$ref': '#/definitions/type/strs'
          },
          npm_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
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
end
