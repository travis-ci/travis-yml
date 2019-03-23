describe Travis::Yml::Schema::Def::Notification::Notifications, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:notifications] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :notifications,
        title: 'Notifications',
        anyOf: [
          {
            type: :object,
            properties: {
              campfire: {
                '$ref': '#/definitions/notification/campfire'
              },
              email: {
                '$ref': '#/definitions/notification/email'
              },
              flowdock: {
                '$ref': '#/definitions/notification/flowdock'
              },
              hipchat: {
                '$ref': '#/definitions/notification/hipchat'
              },
              irc: {
                '$ref': '#/definitions/notification/irc'
              },
              pushover: {
                '$ref': '#/definitions/notification/pushover'
              },
              slack: {
                '$ref': '#/definitions/notification/slack'
              },
              webhooks: {
                '$ref': '#/definitions/notification/webhooks'
              },
              on_success: {
                '$ref': '#/definitions/type/notification_frequency'
              },
              on_failure: {
                '$ref': '#/definitions/type/notification_frequency'
              },
            },
            additionalProperties: false,
            changes: [
              {
                change: :enable,
              },
              {
                change: :inherit,
                keys: [:on_success, :on_failure]
              }
            ],
            normal: true,
            aliases: {
              email: [
                :emails
              ],
              webhooks: [
                :webhook
              ]
            },
            prefix: :email,
          },
          {
            '$ref': '#/definitions/notification/email'
          }
        ],
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/notifications'
      )
    end
  end
end
