describe Travis::Yml::Schema::Def::Addon::Jwts do
  subject { Travis::Yml.schema[:definitions][:addon][:jwts] }

  # it { puts JSON.pretty_generate(described_class.new.exports) }

  it do
    should include(
      '$id': :jwts,
      title: 'JSON Web Tokens',
      deprecated: kind_of(String),
      see: kind_of(Hash),
      anyOf: [
        {
          type: :array,
          items: {
            '$ref': '#/definitions/type/secure'
          },
          deprecated: kind_of(String),
          normal: true
        },
        {
          '$ref': '#/definitions/type/secure'
        }
      ]
    )
  end
end
