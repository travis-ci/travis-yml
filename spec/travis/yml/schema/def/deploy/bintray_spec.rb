describe Travis::Yml::Schema::Def::Deploy::Bintray, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:bintray] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :bintray,
        title: 'Bintray',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'bintray'
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
              file: {
                type: :string
              },
              user: {
                '$ref': '#/definitions/secure'
              },
              key: {
                '$ref': '#/definitions/secure'
              },
              passphrase: {
                '$ref': '#/definitions/secure'
              },
              dry_run: {
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
              'bintray'
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
        '$ref': '#/definitions/deploy/bintray'
      )
    end
  end
end
