describe Travis::Yml::Schema::Def::Env, 'structure' do
  describe 'definitions' do
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
              normal: true,
              prefix: :matrix,
              additionalProperties: false
            },
            {
              '$ref': '#/definitions/type/env_vars'
            }
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
          ]
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
              type: :object,
              patternProperties: {
                '^(?!global|matrix)': {
                  type: :string
                }
              },
              maxProperties: 1,
              normal: true
            },
            {
              type: :string,
              pattern: '^[^=]+=[^=]+$'
            }
          ]
        )
      end
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/type/env'
  #     )
  #   end
  # end
end
