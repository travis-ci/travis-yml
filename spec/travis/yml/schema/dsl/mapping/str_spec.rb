describe Travis::Yml::Schema::Dsl::Map, 'mapping a str' do
  let(:dsl) { const(&define).new }
  let(:map) { dsl.node }
  let(:foo) { map[:foo] }

  def const(&define)
    Class.new(described_class) { define_method(:define, &define) }
  end

  describe 'downcase' do
    let(:define) { -> { map :foo, to: :str, downcase: true } }
    it { expect(foo).to have_opts downcase: true }
    it { expect(map).to_not have_opts }
  end

  describe 'format' do
    let(:define) { -> { map :foo, to: :str, format: '.*' } }
    it { expect(foo).to have_opts format: '.*' }
    it { expect(map).to_not have_opts }
  end

  describe 'default' do
    let(:define) { -> { map :foo, to: :str, vars: 'str' } }
    it { expect(foo).to have_opts vars: ['str'] }
    it { expect(map).to_not have_opts }
  end
end
