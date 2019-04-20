describe Travis::Yml::Schema::Def::Deploy::Puppetforge, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:puppetforge] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :puppetforge,
        title: 'Puppetforge',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'puppetforge'
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
              user: {
                '$ref': '#/definitions/secure'
              },
              password: {
                '$ref': '#/definitions/secure'
              },
              url: {
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
              :provider,
              :user,
              :password
            ]
          },
          {
            type: :string,
            enum: [
              'puppetforge'
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
  #       '$ref': '#/definitions/deploy/puppetforge'
  #     )
  #   end
  # end
end
