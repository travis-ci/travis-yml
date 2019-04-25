describe Travis::Yml::Schema::Def::Notification::Webhooks, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:webhooks] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :notification_webhooks,
        title: 'Notification Webhooks',
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
              urls: {
                '$ref': '#/definitions/type/secures'
              },
              on_start: {
                '$ref': '#/definitions/notification/frequency'
              },
              on_cancel: {
                '$ref': '#/definitions/notification/frequency'
              },
              on_error: {
                '$ref': '#/definitions/notification/frequency'
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
            prefix: :urls,
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/notification/webhooks'
      )
    end
  end
end
