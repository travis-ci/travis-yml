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
                '$ref': '#/definitions/secure'
              },
              app: {
                type: :string
              },
              exclude: {
                '$ref': '#/definitions/strs'
              },
              include: {
                '$ref': '#/definitions/strs'
              },
              address: {
                type: :string
              },
              vcs: {
                type: :boolean
              },
              metadata: {
                '$ref': '#/definitions/strs'
              },
              debug: {
                type: :boolean
              },
              version: {
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
