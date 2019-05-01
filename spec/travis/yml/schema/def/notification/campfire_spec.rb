describe Travis::Yml::Schema::Def::Notification::Campfire, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:campfire] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :notification_campfire,
      title: 'Notification Campfire',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            rooms: {
              '$ref': '#/definitions/type/secures'
            },
            template: {
              '$ref': '#/definitions/notification/templates'
            },
            enabled: {
              type: :boolean
            },
            disabled: {
              type: :boolean
            },
            on_success: {
              '$ref': '#/definitions/notification/frequency'
            },
            on_failure: {
              '$ref': '#/definitions/notification/frequency'
            },
          },
          additionalProperties: false,
          prefix: {
            key: :rooms
          },
          normal: true,
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
