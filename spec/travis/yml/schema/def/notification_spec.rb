describe Travis::Yml::Schema::Def::Notification::Notifications do
  subject { Travis::Yml.schema[:definitions][:type][:notifications] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :notifications,
      title: 'Notifications',
      summary: 'Notification targets to notify on build results',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            campfire: {
              '$ref': '#/definitions/notification/campfire',
              summary: instance_of(String)
            },
            email: {
              '$ref': '#/definitions/notification/email',
              summary: instance_of(String)
            },
            flowdock: {
              '$ref': '#/definitions/notification/flowdock',
              summary: instance_of(String)
            },
            hipchat: {
              '$ref': '#/definitions/notification/hipchat',
              summary: instance_of(String)
            },
            irc: {
              '$ref': '#/definitions/notification/irc',
              summary: instance_of(String)
            },
            pushover: {
              '$ref': '#/definitions/notification/pushover',
              summary: instance_of(String)
            },
            slack: {
              '$ref': '#/definitions/notification/slack',
              summary: instance_of(String)
            },
            webhooks: {
              '$ref': '#/definitions/notification/webhooks',
              summary: instance_of(String)
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
        }
      ],
    )
  end
end
