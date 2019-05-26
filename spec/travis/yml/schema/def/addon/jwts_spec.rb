describe Travis::Yml::Schema::Def::Addon::Jwts do
  subject { Travis::Yml.schema[:definitions][:addon][:jwts] }

  # it { puts JSON.pretty_generate(described_class.new.exports) }

  it do
    should eq(
      '$id': :jwts,
      title: 'JSON Web Tokens',
      anyOf: [
        {
          type: :array,
          items: {
            '$ref': '#/definitions/type/secure'
          },
          normal: true
        },
        {
          '$ref': '#/definitions/type/secure'
        }
      ]
    )
  end
end
