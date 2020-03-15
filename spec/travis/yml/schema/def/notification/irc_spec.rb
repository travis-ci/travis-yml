describe Travis::Yml::Schema::Def::Notification::Irc, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:irc] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :irc,
      title: 'IRC',
      normal: true,
      see: kind_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            enabled: {
              type: :boolean,
              summary: kind_of(String)
            },
            disabled: {
              type: :boolean,
              summary: kind_of(String)
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
              summary: kind_of(String)
            },
            channel_key: {
              '$ref': '#/definitions/type/secure',
              summary: kind_of(String)
            },
            password: {
             '$ref': '#/definitions/type/secure',
              summary: kind_of(String)
            },
            nickserv_password: {
             '$ref': '#/definitions/type/secure',
              summary: kind_of(String)
            },
            nick: {
              '$ref': '#/definitions/type/secure',
              strict: false,
              summary: kind_of(String)
            },
            use_notice: {
              type: :boolean,
              summary: kind_of(String)
            },
            skip_join: {
              type: :boolean,
              summary: kind_of(String)
            },
            template: {
              '$ref': '#/definitions/notification/templates'
            },
            if: {
              '$ref': '#/definitions/type/condition'
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
