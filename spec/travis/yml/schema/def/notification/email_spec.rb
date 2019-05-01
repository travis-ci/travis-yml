describe Travis::Yml::Schema::Def::Notification::Email, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:email] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :notification_email,
      title: 'Notification Email',
      normal: true,
      aliases: [
        :emails
      ],
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
              '$ref': '#/definitions/type/secures'
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
          '$ref': '#/definitions/type/secures'
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
