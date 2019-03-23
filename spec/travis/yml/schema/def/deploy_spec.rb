describe Travis::Yml::Schema::Def::Deploy::Deploy, 'structure' do
  describe 'definitions' do
    # it { puts JSON.pretty_generate(subject) }

    # describe 'deploys' do
    #   subject { Travis::Yml::Schema::Def::Deploy::Deploys.new(nil, {}).definitions[:type][:deploys] }
    #   it { puts JSON.pretty_generate(subject)[0..400] }
    # end

    describe 'deploy_conditions' do
      subject { Travis::Yml.schema[:definitions][:type][:deploy_conditions] }

      it do
        should eq(
          '$id': :deploy_conditions,
          title: 'Deploy Conditions',
          anyOf: [
            {
              allOf: [
                {
                  type: :object,
                  properties: {
                    branch: {
                      '$ref': '#/definitions/type/deploy_branches'
                    },
                    repo: {
                      type: :string
                    },
                    condition: {
                      type: :string
                    },
                    all_branches: {
                      type: :boolean
                    },
                    tags: {
                      type: :boolean
                    }
                  },
                  normal: true,
                  prefix: :branch,
                  aliases: {
                    branch: [
                      :branches
                    ]
                  },
                  additionalProperties: false,
                },
                {
                  '$ref': '#/definitions/type/languages'
                },
              ],
              normal: true
            },
            {
              '$ref': '#/definitions/type/deploy_branches'
            }
          ]
        )
      end
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: ['deploy'],
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
            },
            changes: [
              {
                change: :enable
              }
            ],
            prefix: :provider,
            normal: true,
            required: [:provider]
          },
          {
            type: :string,
            enum: ['deploy'],
            strict: true
          }
        ]
      )
    end
  end
end
