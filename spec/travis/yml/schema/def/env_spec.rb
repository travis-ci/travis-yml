describe Travis::Yml::Schema::Def::Env do
  describe 'env' do
    subject { Travis::Yml.schema[:definitions][:type][:env] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :env,
        title: 'Env',
        summary: 'Environment variables to set up',
        description: <<~str.chomp,
          The key `env` defines env vars that will be defined in the build
          environment.

          Env vars can be specified as global or matrix vars. Global vars
          will be defined on every job in the build's job matrix. Matrix
          vars will expand the matrix, i.e. create one additional job per
          entry.

          Env vars can be given either as strings or maps. If given as a
          string they can contain multiple key/value pairs.
        str
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
                summary: 'Environment variables that expand the build matrix (creating one job per entry)',
                flags: [
                  :expand
                ]
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
