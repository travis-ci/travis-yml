describe Travis::Yml::Schema::Examples::Bool do
  let(:node) { Travis::Yml::Schema::Type::Bool.new }
  subject { described_class.new(node).examples }

  it { should eq [true] }
end
