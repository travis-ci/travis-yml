describe Travis::Yml::Schema::Examples::Str do
  let(:node) { Travis::Yml::Schema::Type::Str.new }

  subject { described_class.new(node).example }

  it { should eq 'a string' }
end
