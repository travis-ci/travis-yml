describe Travis::Yml::Schema::Json::Scalar do
  let(:node) { Travis::Yml::Schema::Dsl::Node[type].new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  describe 'default' do
    describe 'given a bool' do
      let(:type) { :bool }
      let(:opts) { { default: true } }
      it { should have_schema type: :boolean, defaults: [value: true] }
    end

    describe 'given a num' do
      let(:type) { :num }
      let(:opts) { { default: 1 } }
      it { should have_schema type: :number, defaults: [value: 1] }
    end

    describe 'given a bool' do
      let(:type) { :str }
      let(:opts) { { default: 'str' } }
      it { should have_schema type: :string, defaults: [value: 'str'] }
    end
  end
end
