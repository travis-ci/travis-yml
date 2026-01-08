describe Travis::Yml::Schema::Def::Notification::Webhooks, 'structure' do
  subject { Travis::Yml.schema[:definitions][:notification][:webhooks] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :webhooks,
      title: 'Webhooks',
      see: kind_of(Hash),
      normal: true,
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
            urls: {
              anyOf: [
                {
                  type: :array,
                  normal: true,
                  items: {
                    anyOf: [
                      {
                        type: :object,
                        properties: {
                          url: {
                            '$ref': '#/definitions/type/secure',
                            summary: kind_of(String)
                          },
                          msteams: {
                            type: :boolean,
                            summary: kind_of(String)
                          }
                        },
                        required: [:url]
                      },
                      {
                        '$ref': '#/definitions/type/secure',
                        strict: false
                      }
                    ]
                  }
                },
                {
                  type: :object,
                  properties: {
                    url: {
                      '$ref': '#/definitions/type/secure',
                      summary: kind_of(String)
                    },
                    msteams: {
                      type: :boolean,
                      summary: kind_of(String)
                    }
                  },
                  required: [:url]
                },
                {
                  '$ref': '#/definitions/type/secure',
                  strict: false
                },
              ],
              summary: kind_of(String)
            },
            if: {
              '$ref': '#/definitions/type/condition'
            },
            on_start: {
              '$ref': '#/definitions/notification/frequency',
            },
            on_cancel: {
              '$ref': '#/definitions/notification/frequency',
            },
            on_error: {
              '$ref': '#/definitions/notification/frequency',
            },
            on_success: {
              '$ref': '#/definitions/notification/frequency',
            },
            on_failure: {
              '$ref': '#/definitions/notification/frequency',
            }
          },
          additionalProperties: false,
          normal: true,
          prefix: {
            key: :urls
          },
          aliases: [
            :webhook
          ],
          changes: [
            {
              change: :enable,
            }
          ]
        },
        {
          type: :array,
          normal: true,
          items: {
            anyOf: [
              {
                type: :object,
                properties: {
                  url: {
                    '$ref': '#/definitions/type/secure',
                    summary: kind_of(String)
                  },
                  msteams: {
                    type: :boolean,
                    summary: kind_of(String)
                  }
                },
                required: [:url]
              },
              {
                '$ref': '#/definitions/type/secure',
                strict: false
              }
            ]
          }
        },
        {
          type: :object,
          properties: {
            url: {
              '$ref': '#/definitions/type/secure',
              summary: kind_of(String)
            },
            msteams: {
              type: :boolean,
              summary: kind_of(String)
            }
          },
          required: [:url]
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
