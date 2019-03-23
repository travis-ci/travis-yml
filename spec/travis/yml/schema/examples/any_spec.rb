describe Travis::Yml::Schema::Examples::Any do
  let(:dsl) { Travis::Yml::Schema::Dsl::Any.new }
  let(:node) { dsl.node }

  before do
    dsl.add :str, :bool
  end

  subject { described_class.new(node).example }

  it { should eq ['a string', true] }
end
