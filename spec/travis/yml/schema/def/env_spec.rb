describe Travis::Yml::Schema::Def::Env do
  describe 'env' do
    subject { Travis::Yml.schema[:definitions][:type][:env] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :env,
        title: 'Env',
        summary: kind_of(String),
        description: kind_of(String),
        see: kind_of(Hash),
        anyOf: [
          {
            type: :object,
            properties: {
              global: {
                '$ref': '#/definitions/type/env_vars',
                summary: kind_of(String),
              },
              jobs: {
                '$ref': '#/definitions/type/env_vars',
                summary: kind_of(String),
                aliases: [
                  :matrix
                ],
                flags: [
                  :expand
                ]
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :jobs
            },
          },
          {
            '$ref': '#/definitions/type/env_vars'
          }
        ],
      )
    end
  end

  describe 'env_vars' do
    subject { Travis::Yml.schema[:definitions][:type][:env_vars] }

    it do
      should eq(
        '$id': :env_vars,
        title: 'Env Vars',
        summary: 'Environment variables to set up',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/env_var'
            },
            normal: true,
            changes: [
              {
                change: :env_vars
              }
            ]
          },
          {
            '$ref': '#/definitions/type/env_var'
          }
        ],
      )
    end
  end

  describe 'env_var' do
    subject { Travis::Yml.schema[:definitions][:type][:env_var] }

    it do
      should eq(
        '$id': :env_var,
        title: 'Env Var',
        anyOf: [
          {
            type: :object,
            example: {
              FOO: 'foo'
            },
            patternProperties: {
              '^(?!global|jobs|matrix)': {
                anyOf: [
                  {
                    type: :string
                  },
                  {
                    type: :number
                  },
                  {
                    type: :boolean
                  },
                  {
                    '$ref': '#/definitions/type/secure'
                  }
                ]
              }
            },
            normal: true,
          },
          {
            type: :object,
            properties: {
              secure: {
                type: :string
              }
            },
            additionalProperties: false,
            maxProperties: 1,
            normal: true
          },
          {
            type: :string,
            example: 'FOO=foo',
            pattern: '^[^=]+=[^=]*$'
          }
        ]
      )
    end
  end
end
