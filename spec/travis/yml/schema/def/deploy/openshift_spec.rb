describe Travis::Yml::Schema::Def::Deploy::Openshift, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:openshift] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :openshift,
        title: 'Openshift',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'openshift'
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
              domain: {
                type: :string
              },
              app: {
                type: :string
              },
              deployment_branch: {
                type: :string
              }
            },
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ],
            changes: [
              {
                change: :enable
              }
            ]
          },
          {
            type: :string,
            enum: [
              'openshift'
            ],
            strict: true
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/openshift'
      )
    end
  end
end
