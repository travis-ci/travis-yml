describe Travis::Yml::Schema::Def::Notification::Hipchat, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:hipchat] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :hipchat,
        title: 'Hipchat',
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
              rooms: {
                '$ref': '#/definitions/secures'
              },
              format: {
                type: :string,
                enum: [
                  'html',
                  'text'
                ]
              },
              notify: {
                type: :boolean
              },
              on_pull_requests: {
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
            prefix: :rooms,
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
        '$ref': '#/definitions/notification/hipchat'
      )
    end
  end
end
