describe Travis::Yml::Schema::Examples::Num do
  let(:node) { Travis::Yml::Schema::Type::Num.new }
  subject { described_class.new(node).examples }

  it { should eq [1] }
end
