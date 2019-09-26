describe Travis::Yml::Schema::Def::Notification::Flowdock, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:flowdock] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :flowdock,
      title: 'Flowdock',
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
            api_token: {
             '$ref': '#/definitions/type/secure',
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
            }
          },
          additionalProperties: false,
          normal: true,
          prefix: {
            key: :api_token
          },
          changes: [
            {
              change: :enable,
            }
          ]
        },
        {
          '$ref': '#/definitions/type/secure'
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
