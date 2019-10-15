describe Travis::Yml::Doc::Schema, 'jobs' do
  subject { schema.matches?(build_value(value)) }

  describe 'env with a map jobs: str' do
    let(:schema) { Travis::Yml.expand['env'] }
    let(:value)  { 'foo' }
    it { should be true }
  end

  describe 'env with a secure' do
    let(:schema) { Travis::Yml.expand['env'] }
    let(:value)  { { secure: 'foo' } }
    it { should be true }
  end

  describe 'env.jobs with a secure' do
    let(:schema) { Travis::Yml.expand['env'][0]['jobs'] }
    let(:value)  { { secure: 'foo' } }
    it { should be true }
  end
end
