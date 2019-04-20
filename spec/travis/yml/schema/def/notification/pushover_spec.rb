describe Travis::Yml::Schema::Def::Notification::Pushover, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:notification][:pushover] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :pushover,
        title: 'Pushover',
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
            anyOf: [
              {
                type: :array,
                items: {
                  type: :string,
                  vars: [
                    'repository',
                    'repository_slug',
                    'repository_name',
                    'build_number',
                    'build_id',
                    'build_url',
                    'branch',
                    'commit',
                    'commit_subject',
                    'commit_message',
                    'author',
                    'pull_request',
                    'pull_request_number',
                    'pull_request_url',
                    'compare_url',
                    'result',
                    'duration',
                    'elapsed_time',
                    'message'
                  ]
                },
                normal: true
              },
              {
                type: :string,
                vars: [
                  'repository',
                  'repository_slug',
                  'repository_name',
                  'build_number',
                  'build_id',
                  'build_url',
                  'branch',
                  'commit',
                  'commit_subject',
                  'commit_message',
                  'author',
                  'pull_request',
                  'pull_request_number',
                  'pull_request_url',
                  'compare_url',
                  'result',
                  'duration',
                  'elapsed_time',
                  'message'
                ]
              }
            ]
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
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/notification/pushover'
  #     )
  #   end
  # end
end
