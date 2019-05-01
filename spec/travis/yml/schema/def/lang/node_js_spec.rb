describe Travis::Yml::Schema::Def::NodeJs, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:node_js] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_node_js,
        title: 'Language Node Js',
        type: :object,
        properties: {
          node_js: {
            '$ref': '#/definitions/type/strs',
            aliases: [
              :node
            ],
            flags: [
              :expand
            ],
            only: {
              language: [
                'node_js'
              ]
            }
          },
          npm_args: {
            type: :string,
            only: {
              language: [
                'node_js'
              ]
            }
          }
        },
        normal: true
    )
  end
end
