describe Travis::Yml::Schema::Dsl::Str do
  let(:dsl)  { Class.new(described_class).new }

  subject { dsl.node}

  describe 'default' do
    before { dsl.default :str }
    it { should have_opts defaults: [{ value: 'str' }] }
  end

  describe 'downcase' do
    before { dsl.downcase }
    it { should have_opts downcase: true }
  end

  describe 'format' do
    before { dsl.format('.*') }
    it { should have_opts format: '.*' }
  end

  describe 'vars' do
    before { dsl.vars('str') }
    it { should have_opts vars: ['str'] }
  end
end
