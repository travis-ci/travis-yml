describe Travis::Yml::Schema::Examples::Secure do
  let(:dsl) { Travis::Yml::Schema::Dsl::Secure.new }
  let(:node) { dsl.node }

  subject { described_class.new(node).example }

  it { should eq secure: 'encrypted string' }
end
