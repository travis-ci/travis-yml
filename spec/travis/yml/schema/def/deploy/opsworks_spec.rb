describe Travis::Yml::Schema::Def::Deploy::Opsworks do
  subject { Travis::Yml.schema[:definitions][:deploy][:opsworks] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :opsworks,
        title: 'Opsworks',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'opsworks'
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
              skip_cleanup: {
                type: :boolean
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
              app_id: {
                type: :string
              },
              instance_ids: {
                type: :string
              },
              layer_ids: {
                type: :string
              },
              migrate: {
                type: :boolean
              },
              wait_until_deployed: {
                type: :boolean
              },
              custom_json: {
                type: :string
              },
              update_on_success: {
                type: :boolean,
                aliases: [
                  :update_app_on_success
                ]
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
              'opsworks'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
