describe Travis::Yml::Schema::Def::Deploy::Convox do
  subject { Travis::Yml.schema[:definitions][:deploy][:convox] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :convox,
      title: 'Convox',
      anyOf: [
        {
          type: :object,
          properties: {
            host: {
              type: :string
            },
            app: {
              type: :string
            },
            rack: {
              type: :string
            },
            password: {
              '$ref': '#/definitions/type/secure'
            },
            install_url: {
              type: :string
            },
            update_cli: {
              type: :boolean
            },
            create: {
              type: :boolean
            },
            promote: {
              type: :boolean
            },
            env: {
              '$ref': '#/definitions/type/strs'
            },
            env_file: {
              type: :string
            },
            description: {
              type: :string
            },
            generation: {
              type: :number
            },
            provider: {
              type: :string,
              enum: [
                'convox'
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
            :app,
            :rack,
            :password,
            :provider
          ]
        },
        {
          type: :string,
          enum: [
            'convox'
          ],
          strict: true
        }
      ],
      normal: true
    )
  end
end
