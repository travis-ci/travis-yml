describe Travis::Yml::Schema::Def::Addon::Jwts, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:jwts] }

    # it { puts JSON.pretty_generate(described_class.new.exports) }

    it do
      should eq(
        '$id': :jwts,
        title: 'JSON Web Tokens',
        '$ref': '#/definitions/secures'
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/addon/jwts'
  #     )
  #   end
  # end
end
