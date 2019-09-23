describe Travis::Yml::Schema::Def::Addon::Jwts do
  subject { Travis::Yml.schema[:definitions][:addon][:jwts] }

  # it { puts JSON.pretty_generate(described_class.new.exports) }

  it do
    should include(
      '$id': :jwts,
      title: 'JSON Web Tokens',
      deprecated: instance_of(String),
      see: instance_of(Hash),
      anyOf: [
        {
          type: :array,
          items: {
            '$ref': '#/definitions/type/secure'
          },
          deprecated: instance_of(String),
          normal: true
        },
        {
          '$ref': '#/definitions/type/secure'
        }
      ]
    )
  end
end
