describe Travis::Yml::Schema::Def::Notification::Campfire, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:campfire] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :campfire,
        title: 'Campfire',
        anyOf: [
          {
            type: :object,
            properties: {
              rooms: {
                '$ref': '#/definitions/secures'
              },
              template: {
                '$ref': '#/definitions/notification/templates'
              },
              enabled: {
                type: :boolean
              },
              disabled: {
                type: :boolean
              },
              on_success: {
                '$ref': '#/definitions/notification/frequency'
              },
              on_failure: {
                '$ref': '#/definitions/notification/frequency'
              },
            },
            additionalProperties: false,
            prefix: :rooms,
            normal: true,
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
        '$ref': '#/definitions/notification/campfire'
      )
    end
  end
end
