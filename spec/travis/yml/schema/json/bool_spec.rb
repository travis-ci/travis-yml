describe Travis::Yml::Schema::Json::Bool do
  let(:node) { Travis::Yml::Schema::Dsl::Bool.new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  it { should_not have_definitions }
  it { should have_schema type: :boolean }
end
