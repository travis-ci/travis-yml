describe Travis::Yml::Schema::Def::Notification::Pushover, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:pushover] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :pushover,
        title: 'Pushover',
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
                '$ref': '#/definitions/secure'
              },
              users: {
                '$ref': '#/definitions/secures'
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/notification/pushover'
      )
    end
  end
end
