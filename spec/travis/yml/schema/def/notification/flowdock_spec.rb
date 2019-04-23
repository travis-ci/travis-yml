describe Travis::Yml::Schema::Def::Notification::Flowdock, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:flowdock] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :notification_flowdock,
        title: 'Notification Flowdock',
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
               '$ref': '#/definitions/secure'
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
            prefix: :api_token,
            changes: [
              {
                change: :enable,
              }
            ]
          },
          {
            '$ref': '#/definitions/secure'
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
        '$ref': '#/definitions/notification/flowdock'
      )
    end
  end
end
