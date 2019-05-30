describe Travis::Yml::Schema::Json::Str do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Str) do
      define_method(:define, &define)
    end
  end

  subject { const(define).new }

  describe 'downcase' do
    let(:define) { -> { downcase } }
    it { should have_schema type: :string, downcase: true }
  end

  describe 'format' do
    let(:define) { -> { format '.*' } }
    it { should have_schema type: :string, pattern: '.*' }
  end

  describe 'vars' do
    let(:define) { -> { vars 'one', 'two' } }
    it { should have_schema type: :string, vars: ['one', 'two'] }
  end
end
