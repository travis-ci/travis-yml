describe Travis::Yml::Schema::Def::Deploy::Divshot, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:divshot] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :divshot,
        title: 'Divshot',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'divshot'
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
              api_key: {
                '$ref': '#/definitions/secure'
              },
              environment: {
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
              'divshot'
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
  #       '$ref': '#/definitions/deploy/divshot'
  #     )
  #   end
  # end
end
