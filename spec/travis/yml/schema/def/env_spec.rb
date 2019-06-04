describe Travis::Yml::Schema::Def::Env do
  describe 'env' do
    subject { Travis::Yml.schema[:definitions][:type][:env] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :env,
        title: 'Env',
        summary: 'Environment variables to set up',
        anyOf: [
          {
            type: :object,
            properties: {
              global: {
                '$ref': '#/definitions/type/env_vars',
                summary: 'Global environment variables to be defined on all jobs'
              },
              matrix: {
                '$ref': '#/definitions/type/env_vars',
                summary: 'Environment variables that expand the build matrix (i.e. that create one job per entry)'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :matrix
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
              '^(?!global|matrix)': {
                anyOf: [
                  {
                    type: :string
                  },
                  {
                    type: :number
                  },
                  {
                    type: :boolean
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
