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
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/campfire',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/campfire',
                }
              ],
              summary: kind_of(String)
            },
            email: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/email',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/email',
                }
              ],
              summary: kind_of(String)
            },
            flowdock: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/flowdock',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/flowdock',
                }
              ],
              summary: kind_of(String)
            },
            hipchat: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/hipchat',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/hipchat',
                }
              ],
              summary: kind_of(String)
            },
            irc: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/irc',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/irc',
                }
              ],
              summary: kind_of(String)
            },
            pushover: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/pushover',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/pushover',
                }
              ],
              summary: kind_of(String)
            },
            slack: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/slack',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/slack',
                }
              ],
              summary: kind_of(String)
            },
            webhooks: {
              anyOf: [
                {
                  type: :array,
                  items: {
                    '$ref': '#/definitions/notification/webhooks',
                  },
                  normal: true
                },
                {
                  '$ref': '#/definitions/notification/webhooks',
                }
              ],
              summary: kind_of(String)
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
          type: :array,
          items: {
            '$ref': '#/definitions/notification/email',
          },
          normal: true
        },
        {
          '$ref': '#/definitions/notification/email',
        }
      ],
    )
  end
end
