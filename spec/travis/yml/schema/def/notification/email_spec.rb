describe Travis::Yml::Schema::Def::Notification::Email, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:email] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :notification_email,
        title: 'Notification Email',
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
                '$ref': '#/definitions/secures'
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
            prefix: :recipients,
            changes: [
              {
                change: :enable,
              }
            ]
          },
          {
            '$ref': '#/definitions/secures'
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
        '$ref': '#/definitions/notification/email'
      )
    end
  end
end
