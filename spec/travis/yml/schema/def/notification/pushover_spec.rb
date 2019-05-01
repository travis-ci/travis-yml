describe Travis::Yml::Schema::Def::Notification::Pushover, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:pushover] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :notification_pushover,
      title: 'Notification Pushover',
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
            api_key: {
              '$ref': '#/definitions/type/secures'
            },
            users: {
              '$ref': '#/definitions/type/secures'
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
          changes: [
            {
              change: :enable,
            }
          ]
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
