describe Travis::Yml::Schema::Def::Notification::Campfire, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:campfire] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :campfire,
      title: 'Campfire',
      normal: true,
      see: instance_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            rooms: {
              '$ref': '#/definitions/type/secures',
              summary: instance_of(String)
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
            },
            enabled: {
              type: :boolean,
              summary: instance_of(String)
            },
            disabled: {
              type: :boolean,
              summary: instance_of(String)
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
