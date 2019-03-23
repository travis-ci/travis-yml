describe Travis::Yml::Schema::Examples::Map do
  let(:dsl) { Travis::Yml::Schema::Dsl::Map.new }
  let(:node) { dsl.node }

  subject { described_class.new(node).examples }

  describe 'mapping a str' do
    before { dsl.map :foo, to: :str }
    it { should eq [foo: 'Foo'] }
  end

  describe 'mapping a num' do
    before { dsl.map :foo, to: :num }
    it { should eq [foo: 1] }
  end

  describe 'mapping a bool' do
    before { dsl.map :foo, to: :bool }
    it { should eq [foo: true] }
  end

  describe 'mapping a seq of strs' do
    before { dsl.map :foo, to: :seq }
    it { should eq [foo: ['a string']] }
  end

  describe 'mapping a seq of maps' do
    before { dsl.map :foo, to: :seq, type: :map }
    it { should eq [foo: [{}]] } # hmmm.
  end

  describe 'mapping a seq of strs' do
    before do
      dsl.map :foo, to: :seq, type: Class.new(Travis::Yml::Schema::Dsl::Any) {
        def define
          add :seq
          add :str
        end
      }
    end

    xit { should eq foo: [['a string'], 'a string'] }
  end

  # it { puts Travis::Yml::Schema::Def::Addon::CoverityScan.new.node.dump }
end
