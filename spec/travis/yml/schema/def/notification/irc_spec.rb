describe Travis::Yml::Schema::Def::Notification::Irc, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:irc] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :irc,
      title: 'IRC',
      normal: true,
      see: instance_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            enabled: {
              type: :boolean,
              summary: instance_of(String)
            },
            disabled: {
              type: :boolean,
              summary: instance_of(String)
            },
            channels: {
              anyOf: [
                {
                  type: :array,
                  normal: true,
                  aliases: [
                    :channel
                  ],
                  items: {
                    '$ref': '#/definitions/type/secure',
                    strict: false
                  }
                },
                {
                  '$ref': '#/definitions/type/secure',
                  strict: false
                },
              ],
              summary: instance_of(String)
            },
            channel_key: {
              '$ref': '#/definitions/type/secure',
              summary: instance_of(String)
            },
            password: {
             '$ref': '#/definitions/type/secure',
              summary: instance_of(String)
            },
            nickserv_password: {
             '$ref': '#/definitions/type/secure',
              summary: instance_of(String)
            },
            nick: {
             '$ref': '#/definitions/type/secure',
              summary: instance_of(String)
            },
            use_notice: {
              type: :boolean,
              summary: instance_of(String)
            },
            skip_join: {
              type: :boolean,
              summary: instance_of(String)
            },
            template: {
              '$ref': '#/definitions/notification/templates'
            },
            on_success: {
              '$ref': '#/definitions/notification/frequency'
            },
            on_failure: {
              '$ref': '#/definitions/notification/frequency'
            }
          },
          additionalProperties: false,
          normal: true,
          prefix: {
            key: :channels
          },
          changes: [
            {
              change: :enable,
            }
          ],
        },
        {
          type: :array,
          normal: true,
          aliases: [
            :channel
          ],
          items: {
            '$ref': '#/definitions/type/secure',
            strict: false
          }
        },
        {
          '$ref': '#/definitions/type/secure',
          strict: false
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
