describe Travis::Yml::Schema::Def::Deploy::Deploy do
  # describe 'deploys' do
  #   subject { Travis::Yml::Schema::Def::Deploy::Deploys.new(nil, {}).definitions[:type][:deploys] }
  #   it { puts JSON.pretty_generate(subject)[0..400] }
  # end

  describe 'conditions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:conditions] }

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
                additionalProperties: false,
                prefix: {
                  key: :branch,
                  only: [
                    :str
                  ],
                },
                properties: {
                  branch: {
                    '$ref': '#/definitions/deploy/branches',
                    aliases: [
                      :branches
                    ]
                  },
                  os: {
                    '$ref': '#/definitions/type/os',
                  },
                  repo: {
                    type: :string
                  },
                  condition: {
                    '$ref': '#/definitions/type/strs'
                  },
                  all_branches: {
                    type: :boolean
                  },
                  tags: {
                    type: :boolean
                  },
                },
              },
              {
                '$ref': '#/definitions/type/support'
              }
            ],
            normal: true,
          },
          {
            '$ref': '#/definitions/deploy/branches',
            aliases: [
              :branches
            ]
          }
        ]
      )
    end
  end
end
