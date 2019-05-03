describe Travis::Yml::Schema::Def::Notification::Email, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:email] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :notification_email,
      title: 'Notification Email',
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
            recipients: {
              anyOf: [
                {
                  type: :array,
                  normal: true,
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
            key: :recipients
          },
          aliases: [
            :emails
          ],
          changes: [
            {
              change: :enable,
            }
          ]
        },
        {
          type: :array,
          items: {
            '$ref': '#/definitions/type/secure',
            strict: false
          },
          normal: true # this should not be normal
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
