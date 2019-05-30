describe Travis::Yml::Schema::Def::Deploy::Testfairy do
  subject { Travis::Yml.schema[:definitions][:deploy][:testfairy] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :testfairy,
        title: 'Testfairy',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'testfairy'
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
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              app_file: {
                type: :string
              },
              symbols_file: {
                type: :string
              },
              testers_groups: {
                type: :string
              },
              notify: {
                type: :boolean
              },
              auto_update: {
                type: :boolean
              },
              video_quality: {
                type: :string
              },
              screenshot_quality: {
                type: :string
              },
              screenshot_interval: {
                type: :number
              },
              max_duration: {
                type: :string
              },
              advanced_options: {
                type: :string
              },
              data_only_wifi: {
                type: :boolean
              },
              record_on_background: {
                type: :boolean
              },
              video: {
                type: :boolean
              },
              icon_watermark: {
                type: :boolean
              },
              metrics: {
                type: :string
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider
            },
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'testfairy'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
