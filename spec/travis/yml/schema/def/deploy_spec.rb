describe Travis::Yml::Schema::Def::Deploy::Deploy do
  describe 'conditions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:conditions] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :conditions,
        title: 'Conditions',
        anyOf: [
          {
            allOf: [
              {
                type: :object,
                additionalProperties: false,
                aliases: [
                  :true
                ],
                prefix: {
                  key: :branch,
                  only: [
                    :str
                  ],
                },
                properties: {
                  branch: {
                    '$ref': '#/definitions/deploy/branches',
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
          }
        ]
      )
    end
  end
end
