describe Travis::Yml::Schema::Def::Deploy::Lambda do
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
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
              },
              run: {
                '$ref': '#/definitions/type/strs',
              },
              allow_failure: {
                type: :boolean
              },
              cleanup: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean,
                deprecated: 'not supported in dpl v2, use cleanup'
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
              access_key_id: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              secret_access_key: {
                '$ref': '#/definitions/type/secure'
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
              environment: {
                '$ref': '#/definitions/type/secures',
                aliases: [
                  :environment_variables
                ]
              },
              security_group_ids: {
                '$ref': '#/definitions/type/strs'
              },
              subnet_ids: {
                '$ref': '#/definitions/type/strs'
              },
              dead_letter_arn: {
                type: :string
              },
              kms_key_arn: {
                type: :string
              },
              layers: {
                '$ref': '#/definitions/type/strs'
              },
              tracing_mode: {
                type: :string,
                enum: [
                  'Active',
                  'PassThrough'
                ],
              },
              publish: {
                type: :boolean
              },
              function_tags: {
                '$ref': '#/definitions/type/secures'
              },
              dot_match: {
                type: :boolean
              },
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider,
              only: [
                :str
              ]
            },
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
        ],
        normal: true
    )
  end
end
