describe Travis::Yml::Schema::Def::Addon::CodeClimate, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:code_climate] }

    # it { puts JSON.pretty_generate(described_class.new.exports) }

    it do
      should eq(
        '$id': :code_climate,
        title: 'Code Climate',
        anyOf: [
          {
            type: :object,
            properties: {
              repo_token: {
                '$ref': '#/definitions/secure'
              }
            },
            normal: true,
            prefix: :repo_token,
            additionalProperties: false
          },
          {
            '$ref': '#/definitions/secure'
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/addon/code_climate'
      )
    end
  end
end
