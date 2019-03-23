describe Travis::Yml::Doc::Schema, 'matrix' do
  subject { schema.matches?(build_value(value)) }

  describe 'env with a map matrix: str' do
    let(:schema) { Travis::Yml.expand[:env] }
    let(:value)  { 'foo' }
    it { should be false }
  end

  describe 'env with a secure' do
    let(:schema) { Travis::Yml.expand[:env] }
    let(:value)  { { secure: 'foo' } }
    it { should be true }
  end

  describe 'env.matrix with a secure' do
    let(:schema) { Travis::Yml.expand[:env][0][:matrix] }
    let(:value)  { { secure: 'foo' } }
    it { should be true }
  end
end
