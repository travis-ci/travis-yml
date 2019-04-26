describe Travis::Yml::Schema::Def::Deploy::Atlas, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:atlas] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_atlas,
        title: 'Deploy Atlas',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'atlas'
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
              token: {
                '$ref': '#/definitions/type/secure'
              },
              app: {
                type: :string
              },
              exclude: {
                '$ref': '#/definitions/type/strs'
              },
              include: {
                '$ref': '#/definitions/type/strs'
              },
              address: {
                type: :string
              },
              metadata: {
                '$ref': '#/definitions/type/strs'
              },
              debug: {
                type: :boolean
              },
              vcs: {
                type: :boolean
              },
              version: {
                type: :boolean
              }
            },
            additionalProperties: false,
            prefix: :provider,
            required: [
              :provider
            ],
            normal: true
          },
          {
            type: :string,
            enum: [
              'atlas'
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
        '$ref': '#/definitions/deploy/atlas'
      )
    end
  end
end
