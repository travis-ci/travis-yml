describe Travis::Yml::Schema::Examples::Seq do
  let(:dsl) { Travis::Yml::Schema::Dsl::Seq.new }
  let(:node) { dsl.node }

  subject { described_class.new(node).example }

  before do
    dsl.type :str
  end

  it { should eq ['a string'] }
end
