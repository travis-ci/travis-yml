describe Travis::Yml::Schema::Def::Notification::Irc, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:irc] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :notification_irc,
        title: 'IRC',
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
              channels: {
                '$ref': '#/definitions/type/secures'
              },
              channel_key: {
                '$ref': '#/definitions/type/secure'
              },
              password: {
               '$ref': '#/definitions/type/secure'
              },
              nickserv_password: {
               '$ref': '#/definitions/type/secure'
              },
              nick: {
               '$ref': '#/definitions/type/secure'
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
            prefix: {
              key: :channels
            },
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
        '$ref': '#/definitions/notification/irc'
      )
    end
  end
end
