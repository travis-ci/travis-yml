describe Travis::Yml::Schema::Def::Cache, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:cache] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :cache,
        title: 'Cache',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              apt: {
                type: :boolean
              },
              bundler: {
                type: :boolean
              },
              cargo: {
                type: :boolean
              },
              ccache: {
                type: :boolean
              },
              cocoapods: {
                type: :boolean
              },
              npm: {
                type: :boolean
              },
              packages: {
                type: :boolean
              },
              pip: {
                type: :boolean
              },
              yarn: {
                type: :boolean
              },
              edge: {
                type: :boolean,
                flags: [
                  :edge
                ]
              },
              directories: {
                '$ref': '#/definitions/type/strs'
              },
              timeout: {
                type: :number
              },
              branch: {
                type: :string
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :directories
            },
            changes: [
              {
                change: :cache
              }
            ]
          },
          {
            '$ref': '#/definitions/type/strs'
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/cache'
      )
    end
  end
end
