describe Travis::Yml::Schema::Def::Deploy::Boxfuse, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:boxfuse] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_boxfuse,
        title: 'Deploy Boxfuse',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'boxfuse'
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
              user: {
                '$ref': '#/definitions/type/secure'
              },
              secret: {
                '$ref': '#/definitions/type/secure'
              },
              configfile: {
                type: :string
              },
              payload: {
                type: :string
              },
              app: {
                type: :string
              },
              version: {
                type: :string
              },
              env: {
                type: :string
              },
              image: {
                type: :string
              },
              extra_args: {
                type: :string
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
              'boxfuse'
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
        '$ref': '#/definitions/deploy/boxfuse'
      )
    end
  end
end
