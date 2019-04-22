describe Travis::Yml::Schema::Def::Deploy::Deploy, 'structure' do
  describe 'definitions' do
    # describe 'deploys' do
    #   subject { Travis::Yml::Schema::Def::Deploy::Deploys.new(nil, {}).definitions[:type][:deploys] }
    #   it { puts JSON.pretty_generate(subject)[0..400] }
    # end

    describe 'deploy_conditions' do
      subject { Travis::Yml.schema[:definitions][:type][:deploy_conditions] }

      # it { puts JSON.pretty_generate(subject) }

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
                  additionalProperties: false,
                  prefix: :branch,
                  keys: {
                    branch: {
                      aliases: [
                        :branches
                      ]
                    }
                  }
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
end
