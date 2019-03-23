describe Travis::Yml::Doc::Change::Enable do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  let(:schema) do
    {
      type: :object,
      properties: {
        foo: {
          type: :object,
          properties: {
            enabled: {
              type: :boolean
            },
            bar: {
              type: :string
            }
          },
          prefix: :bar,
        }
      },
      changes: [
        {
          change: :enable
        }
      ]
    }
  end

  describe 'given a str' do
    let(:value) { { foo: 'str' } }
    it { should serialize_to foo: 'str' }
    it { should_not have_msg }
  end

  describe 'given yes' do
    let(:value) { { foo: 'yes' } }
    it { should serialize_to foo: { enabled: true } }
    it { should_not have_msg }
  end

  describe 'given no' do
    let(:value) { { foo: 'no' } }
    it { should serialize_to foo: { enabled: false } }
    it { should_not have_msg }
  end

  describe 'given a bool' do
    let(:value) { { foo: true } }
    it { should serialize_to foo: { enabled: true } }
    it { should_not have_msg }
  end

  describe 'given a seq' do
    let(:value) { { foo: ['foo'] } }
    it { should serialize_to foo: ['foo'] }
    it { should_not have_msg }
  end

  describe 'given a map' do
    let(:value) { { foo: { bar: 'str' } } }
    it { should serialize_to foo: { bar: 'str' } }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: true' do
    let(:value) { { foo: { enabled: true } } }
    it { should serialize_to foo: { enabled: true } }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: false' do
    let(:value) { { foo: { enabled: false } } }
    it { should serialize_to foo: { enabled: false } }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: yes' do
    let(:value) { { foo: { enabled: true } } }
    it { should serialize_to foo: { enabled: true } }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: no' do
    let(:value) { { foo: { enabled: false } } }
    it { should serialize_to foo: { enabled: false } }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: true' do
    let(:value) { { foo: { disabled: true } } }
    it { should serialize_to foo: { enabled: false } }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: false' do
    let(:value) { { foo: { disabled: false } } }
    it { should serialize_to foo: { enabled: true } }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: yes' do
    let(:value) { { foo: { disabled: true } } }
    it { should serialize_to foo: { enabled: false } }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: no' do
    let(:value) { { foo: { disabled: false } } }
    it { should serialize_to foo: { enabled: true } }
    it { should_not have_msg }
  end

  describe 'given a map with :enabled it ignores :disabled' do
    describe 'enabled: true, disabled: true' do
      let(:value) { { foo: { enabled: true, disabled: true } } }
      it { should serialize_to foo: { enabled: true } }
      it { should_not have_msg }
    end

    describe 'enabled: true, disabled: false' do
      let(:value) { { foo: { enabled: true, disabled: false } } }
      it { should serialize_to foo: { enabled: true } }
      it { should_not have_msg }
    end

    describe 'enabled: false, disabled: true' do
      let(:value) { { foo: { enabled: false, disabled: true } } }
      it { should serialize_to foo: { enabled: false } }
      it { should_not have_msg }
    end

    describe 'enabled: false, disabled: false' do
      let(:value) { { foo: { enabled: false, disabled: false } } }
      it { should serialize_to foo: { enabled: false } }
      it { should_not have_msg }
    end
  end
end
