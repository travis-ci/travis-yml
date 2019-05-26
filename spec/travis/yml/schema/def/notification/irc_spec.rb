describe Travis::Yml::Schema::Def::Notification::Irc, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:irc] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :irc,
      title: 'IRC',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            enabled: {
              type: :boolean
            },
            disabled: {
              type: :boolean
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
              ]
            },
            channel_key: {
              '$ref': '#/definitions/type/secure'
            },
            password: {
             '$ref': '#/definitions/type/secure'
            },
            nickserv_password: {
             '$ref': '#/definitions/type/secure'
            },
            nick: {
             '$ref': '#/definitions/type/secure'
            },
            use_notice: {
              type: :boolean
            },
            skip_join: {
              type: :boolean
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
