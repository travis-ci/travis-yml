describe Travis::Yml::Schema::Def::NodeJs do
  subject { Travis::Yml.schema[:definitions][:language][:node_js] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :node_js,
        title: 'Node Js',
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
