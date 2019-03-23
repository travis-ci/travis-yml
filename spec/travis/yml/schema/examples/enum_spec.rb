describe Travis::Yml::Schema::Examples::Enum do
  let(:dsl) { Travis::Yml::Schema::Dsl::Enum.new }
  let(:node) { dsl.node }

  subject { described_class.new(node).examples }

  before do
    dsl.value 'foo'
  end

  it { should eq ['foo'] }
end
