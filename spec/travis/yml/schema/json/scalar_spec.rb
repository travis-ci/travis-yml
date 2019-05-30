describe Travis::Yml::Schema::Json::Scalar do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Node[type]) do
      define_method(:define, &define)
    end
  end

  subject { const(define).new }

  describe 'default' do
    describe 'given a bool' do
      let(:type) { :bool }
      let(:define) { -> { default true } }
      it { should have_schema type: :boolean, defaults: [value: true] }
    end

    describe 'given a num' do
      let(:type) { :num }
      let(:define) { -> { default 1 } }
      it { should have_schema type: :number, defaults: [value: 1] }
    end

    describe 'given a bool' do
      let(:type) { :str }
      let(:define) { -> { default 'str' } }
      it { should have_schema type: :string, defaults: [value: 'str'] }
    end
  end

  describe 'enum' do
    describe 'given a bool' do
      let(:type) { :bool }
      let(:define) { -> { value true } }
      it { should have_schema type: :boolean, enum: [true] }
    end

    describe 'given a num' do
      let(:type) { :num }
      let(:define) { -> { value 1, 2 } }
      it { should have_schema type: :number, enum: [1, 2] }
    end

    describe 'given a bool' do
      let(:type) { :str }
      let(:define) { -> { value 'one', 'two' } }
      it { should have_schema type: :string, enum: ['one', 'two'] }
    end
  end

  describe 'strict' do
    describe 'given a bool' do
      let(:type) { :bool }
      let(:define) { -> { strict false } }
      it { should have_schema type: :boolean, strict: false }
    end

    describe 'given a num' do
      let(:type) { :num }
      let(:define) { -> { strict false } }
      it { should have_schema type: :number, strict: false }
    end

    describe 'given a bool' do
      let(:type) { :str }
      let(:define) { -> { strict false } }
      it { should have_schema type: :string, strict: false }
    end
  end
end
