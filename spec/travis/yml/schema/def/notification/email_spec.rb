describe Travis::Yml::Schema::Def::Notification::Email, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:email] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :email,
      title: 'Email',
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
              ],
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
