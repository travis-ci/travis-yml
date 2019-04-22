describe Travis::Yml::Schema::Def::Deploy::Lambda, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:lambda] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :lambda,
        title: 'Lambda',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'lambda'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/type/deploy_conditions'
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/type/deploy_edge'
              },
              access_key_id: {
                '$ref': '#/definitions/secure'
              },
              secret_access_key: {
                '$ref': '#/definitions/secure'
              },
              region: {
                type: :string
              },
              function_name: {
                type: :string
              },
              role: {
                type: :string
              },
              handler_name: {
                type: :string
              },
              module_name: {
                type: :string
              },
              zip: {
                type: :string
              },
              description: {
                type: :string
              },
              timeout: {
                type: :string
              },
              memory_size: {
                type: :string
              },
              runtime: {
                type: :string
              },
              environment_variables: {
                '$ref': '#/definitions/secure'
              },
              security_group_ids: {
                '$ref': '#/definitions/strs'
              },
              subnet_ids: {
                '$ref': '#/definitions/strs'
              },
              dead_letter_config: {
                type: :string
              },
              kms_key_arn: {
                type: :string
              },
              tracing_mode: {
                type: :string,
                enum: [
                  'Active',
                  'PassThrough'
                ]
              },
              publish: {
                type: :boolean
              },
              function_tags: {
                '$ref': '#/definitions/secure'
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
              'lambda'
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
        '$ref': '#/definitions/deploy/lambda'
      )
    end
  end
end
