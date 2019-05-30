describe Travis::Yml::Schema::Json::Secure do
  subject { Travis::Yml::Schema::Type::Secure.new }

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
