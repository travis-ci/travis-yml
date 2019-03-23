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
          node_js: {
            '$ref': '#/definitions/strs'
          },
          npm_args: {
            type: :string
          }
        },
        normal: true,
        aliases: {
          node_js: [
            :node
          ]
        },
        only: {
          node_js: {
            language: [
              'node_js'
            ]
          },
          npm_args: {
            language: [
              'node_js'
            ]
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
