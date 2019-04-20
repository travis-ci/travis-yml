describe Travis::Yml::Schema::Def::Deploy::Catalyze, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:catalyze] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :catalyze,
        title: 'Catalyze',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'catalyze'
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
              target: {
                type: :string
              },
              path: {
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
              'catalyze'
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
  #       '$ref': '#/definitions/deploy/catalyze'
  #     )
  #   end
  # end
end
