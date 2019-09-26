describe Travis::Yml::Schema::Def::Notification::Pushover, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:pushover] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :pushover,
      title: 'Pushover',
      normal: true,
      see: instance_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            api_key: {
              '$ref': '#/definitions/type/secures',
              summary: instance_of(String)
            },
            users: {
              '$ref': '#/definitions/type/secures',
              summary: instance_of(String)
            },
            template: {
              '$ref': '#/definitions/notification/templates',
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
