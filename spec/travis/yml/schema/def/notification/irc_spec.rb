describe Travis::Yml::Schema::Def::Notification::Irc, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:irc] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :notification_irc,
        title: 'IRC',
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
              channels: {
                '$ref': '#/definitions/secures'
              },
              channel_key: {
                '$ref': '#/definitions/secure'
              },
              password: {
               '$ref': '#/definitions/secure'
              },
              nickserv_password: {
               '$ref': '#/definitions/secure'
              },
              nick: {
               '$ref': '#/definitions/secure'
              },
              use_notice: {
                type: :boolean
              },
              skip_join: {
                type: :boolean
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
            prefix: :channels,
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
        '$ref': '#/definitions/notification/irc'
      )
    end
  end
end
