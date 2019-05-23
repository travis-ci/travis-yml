describe Travis::Yml::Schema::Def::Env do
  # it { puts JSON.pretty_generate(subject) }

  describe 'env' do
    subject { Travis::Yml.schema[:definitions][:type][:env] }

    it do
      should eq(
        '$id': :env,
        title: 'Env',
        anyOf: [
          {
            type: :object,
            properties: {
              global: {
                '$ref': '#/definitions/type/env_vars'
              },
              matrix: {
                '$ref': '#/definitions/type/env_vars'
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
        flags: [
          :expand
        ]
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
            pattern: '^[^=]+=[^=]*$'
          }
        ]
      )
    end
  end
end
