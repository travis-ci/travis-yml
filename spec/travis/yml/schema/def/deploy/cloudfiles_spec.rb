describe Travis::Yml::Schema::Def::Deploy::Cloudfiles, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:cloudfiles] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :cloudfiles,
        title: 'Cloudfiles',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'cloudfiles'
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
              username: {
                '$ref': '#/definitions/secure'
              },
              api_key: {
                '$ref': '#/definitions/secure'
              },
              region: {
                type: :string
              },
              container: {
                type: :string
              },
              dot_match: {
                type: :boolean
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
              'cloudfiles'
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
        '$ref': '#/definitions/deploy/cloudfiles'
      )
    end
  end
end
