describe Travis::Yml::Doc::Change::Value do
  subject { described_class.new(build_schema(schema), build_value(value, opts)).apply }

  let(:schema) { { type: :string, enum: ['foo'], values: { foo: { aliases: ['bar'] } } } }

  describe 'given a known str' do
    let(:value) { 'foo' }
    it { should serialize_to 'foo' }
    it { should_not have_msg }
  end

  describe 'given an alias' do
    let(:value) { 'bar' }
    it { should serialize_to 'foo' }
    it { should have_msg [:info, :root, :alias, type: :value, alias: 'bar', obj: 'foo'] }
  end

  describe 'given a str containing a newline char' do
    let(:value) { "foo\nbar" }
    it { should serialize_to 'foo' }
    it { should have_msg }
  end

  describe 'given a str with a typo' do
    let(:value) { 'fooh' }
    it { should serialize_to 'foo' }
    it { should have_msg [:warn, :root, :find_value, original: 'fooh', value: 'foo'] }
  end

  describe 'given a str with a unknown special chars' do
    let(:value) { 'foo```' }
    it { should serialize_to 'foo' }
    it { should have_msg [:warn, :root, :clean_value, original: 'foo```', value: 'foo'] }
  end

  describe 'given a str with spaces ' do
    let(:value) { 'foo - "1.1"' }
    it { should serialize_to 'foo' }
    it { should have_msg [:warn, :root, :clean_value, original: 'foo - "1.1"', value: 'foo'] }
  end
end
