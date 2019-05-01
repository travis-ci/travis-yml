describe Travis::Yml::Schema::Def::Notification::Notifications do
  subject { Travis::Yml.schema[:definitions][:type][:notifications] }
  # subject { described_class.new.definitions[:type][:notifications] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :notifications,
      title: 'Notifications',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            campfire: {
              '$ref': '#/definitions/notification/campfire'
            },
            email: {
              '$ref': '#/definitions/notification/email',
              aliases: [
                :emails
              ]
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
              '$ref': '#/definitions/notification/webhooks',
              aliases: [
                :webhook
              ]
            },
            on_success: {
              '$ref': '#/definitions/notification/frequency'
            },
            on_failure: {
              '$ref': '#/definitions/notification/frequency'
            },
          },
          additionalProperties: false,
          normal: true,
          prefix: {
            key: :email
          },
          changes: [
            {
              change: :inherit,
              keys: [:on_success, :on_failure]
            }
          ],
        },
        {
          '$ref': '#/definitions/notification/email',
          aliases: [
            :emails
          ]
        }
      ],
    )
  end
end
