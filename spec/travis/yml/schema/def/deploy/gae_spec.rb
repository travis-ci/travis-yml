describe Travis::Yml::Schema::Def::Deploy::Gae, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:gae] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :gae,
        title: 'Gae',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'gae'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/type/deploy_conditions'
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/type/deploy_edge'
              },
              project: {
                type: :string
              },
              keyfile: {
                type: :string
              },
              config: {
                type: :string
              },
              version: {
                type: :string
              },
              no_promote: {
                type: :boolean
              },
              no_stop_previous_version: {
                type: :boolean
              },
              verbosity: {
                type: :string
              }
            },
            normal: true,
            prefix: :provider,
            changes: [
              {
                change: :enable
              }
            ],
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'gae'
            ],
            strict: true
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
  #       '$ref': '#/definitions/deploy/gae'
  #     )
  #   end
  # end
end
