describe Travis::Yml::Schema::Json::Seq do
  let(:node) { Travis::Yml::Schema::Dsl::Seq.new(nil, opts) }
  let(:opts) { { type: :str } }

  subject { described_class.new(node.node) }

  it do
    should have_schema(
      type: :array,
      items: {
        type: :string
      }
    )
  end
end
