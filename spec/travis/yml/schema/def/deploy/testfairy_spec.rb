describe Travis::Yml::Schema::Def::Deploy::Testfairy, 'structure' do
  describe 'definitions' do
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
              api_key: {
                '$ref': '#/definitions/secure'
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
                type: :string
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
              record_on_backgroup: {
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
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ],
            changes: [
              {
                change: :enable
              }
            ]
          },
          {
            type: :string,
            enum: [
              'testfairy'
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
        '$ref': '#/definitions/deploy/testfairy'
      )
    end
  end
end
