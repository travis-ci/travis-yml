describe Travis::Yml::Schema::Json::Secure do
  let(:node) { Travis::Yml::Schema::Dsl::Secure.new(nil, {}) }

  subject { described_class.new(node.node) }

  it do
    should have_schema(
      '$id': :secure,
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
          type: :string,
          normal: true
        }
      ]
    )
  end
end
