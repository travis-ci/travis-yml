describe Travis::Yml::Schema::Def::Notification::Email, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:email] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :email,
        title: 'Email',
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
                '$ref': '#/definitions/type/notification_frequency'
              },
              on_failure: {
                '$ref': '#/definitions/type/notification_frequency'
              },
            },
            additionalProperties: false,
            normal: true,
            prefix: :recipients,
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
  #       '$ref': '#/definitions/notification/email'
  #     )
  #   end
  # end
end
