describe Travis::Yml::Schema::Def::Notification::Flowdock, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:flowdock] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :flowdock,
      title: 'Flowdock',
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
            api_token: {
             '$ref': '#/definitions/type/secure'
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
