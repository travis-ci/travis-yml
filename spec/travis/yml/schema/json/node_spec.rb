describe Travis::Yml::Schema::Json::Str do
  let(:node) { Travis::Yml::Schema::Type::Str.new }

  subject { described_class.new(node) }

  it { should have_schema type: :string }
end
