describe Travis::Yml::Schema::Def::Deploy::Scalingo, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:scalingo] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_scalingo,
        title: 'Deploy Scalingo',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'scalingo'
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
              username: {
                '$ref': '#/definitions/type/secure'
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              remote: {
                type: :string
              },
              branch: {
                type: :string
              },
              app: {
                type: :string
              }
            },
            additionalProperties: false,
            prefix: :provider,
            required: [
              :provider
            ],
            keys: {
              username: {
                aliases: [
                  :user
                ]
              }
            },
            normal: true
          },
          {
            type: :string,
            enum: [
              'scalingo'
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
        '$ref': '#/definitions/deploy/scalingo'
      )
    end
  end
end
