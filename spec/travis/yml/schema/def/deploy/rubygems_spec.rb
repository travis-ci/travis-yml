describe Travis::Yml::Schema::Def::Deploy::Rubygems, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:rubygems] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :rubygems,
        title: 'Rubygems',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'rubygems'
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
              gem: {
                type: :string
              },
              file: {
                type: :string
              },
              gemspec: {
                type: :string
              },
              api_key: {
                '$ref': '#/definitions/secure'
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
              'rubygems'
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
  #       '$ref': '#/definitions/deploy/rubygems'
  #     )
  #   end
  # end
end
