describe Travis::Yml::Schema::Def::Notification::Webhooks, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:webhooks] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :webhooks,
        title: 'Webhooks',
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
                '$ref': '#/definitions/secures'
              },
              on_start: {
                '$ref': '#/definitions/type/notification_frequency'
              },
              on_success: {
                '$ref': '#/definitions/type/notification_frequency'
              },
              on_failure: {
                '$ref': '#/definitions/type/notification_frequency'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: :urls,
          },
          {
            '$ref': '#/definitions/secures'
          }
        ]
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/notification/webhooks'
  #     )
  #   end
  # end
end
