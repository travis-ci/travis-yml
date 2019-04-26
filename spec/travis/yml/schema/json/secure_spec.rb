describe Travis::Yml::Schema::Json::Secure do
  let(:node) { Travis::Yml::Schema::Dsl::Secure.new(nil, {}) }

  subject { described_class.new(node.node) }

  it { should have_definitions }
  it { should have_schema '$ref': '#/definitions/type/secure' }
end
