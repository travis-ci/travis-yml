describe Travis::Yml::Schema::Def::Deploy::Cloudcontrol, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:cloudcontrol] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :cloudcontrol,
        title: 'Cloudcontrol',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'cloudcontrol'
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
              email: {
                '$ref': '#/definitions/secure'
              },
              password: {
                '$ref': '#/definitions/secure'
              },
              deployment: {
                type: :string
              }
            },
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'cloudcontrol'
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
        '$ref': '#/definitions/deploy/cloudcontrol'
      )
    end
  end
end
