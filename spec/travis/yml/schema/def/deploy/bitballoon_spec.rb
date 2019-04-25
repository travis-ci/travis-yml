describe Travis::Yml::Schema::Def::Deploy::Bitballoon, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:bitballoon] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_bitballoon,
        title: 'Deploy Bitballoon',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'bitballoon'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/deploy/conditions'
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
              'access-token': {
                '$ref': '#/definitions/type/secure'
              },
              'site-id': {
                '$ref': '#/definitions/type/secure'
              },
              'local-dir': {
                type: :string
              }
            },
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'bitballoon'
            ],
            strict: true
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/bitballoon'
      )
    end
  end
end
