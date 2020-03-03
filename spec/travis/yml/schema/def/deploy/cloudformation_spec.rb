describe Travis::Yml::Schema::Def::Deploy::Cloudformation do
  subject { Travis::Yml.schema[:definitions][:deploy][:cloudformation] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :cloudformation,
        title: 'Cloudformation',
        anyOf: [
          {
            type: :object,
            properties: {
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
              template: {
                type: :string
              },
              stack_name: {
                type: :string
              },
              stack_name_prefix: {
                type: :string
              },
              promote: {
                type: :boolean
              },
              role_arn: {
                type: :string
              },
              sts_assume_role: {
                type: :string
              },
              capabilities: {
                '$ref': '#/definitions/type/strs'
              },
              wait: {
                type: :boolean
              },
              wait_timeout: {
                type: :number
              },
              create_timeout: {
                type: :number
              },
              parameters: {
                '$ref': '#/definitions/type/strs'
              },
              output_file: {
                type: :string
              },
              provider: {
                type: :string,
                enum: [
                  'cloudformation'
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
                '$ref': '#/definitions/type/strs'
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
              }
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
              'cloudformation'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
