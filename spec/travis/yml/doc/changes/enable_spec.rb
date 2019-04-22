describe Travis::Yml::Doc::Change::Enable do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  let(:schema) do
    {
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
      changes: [
        {
          change: :enable
        }
      ]
    }
  end

  describe 'given a str' do
    let(:value) { 'str' }
    it { should serialize_to 'str' }
    it { should_not have_msg }
  end

  describe 'given yes' do
    let(:value) { 'yes' }
    it { should serialize_to enabled: true }
    it { should_not have_msg }
  end

  describe 'given no' do
    let(:value) { 'no' }
    it { should serialize_to enabled: false }
    it { should_not have_msg }
  end

  describe 'given a bool' do
    let(:value) { true }
    it { should serialize_to enabled: true }
    it { should_not have_msg }
  end

  describe 'given a seq' do
    let(:value) { ['foo'] }
    it { should serialize_to ['foo'] }
    it { should_not have_msg }
  end

  describe 'given a map' do
    let(:value) { { bar: 'str' } }
    it { should serialize_to bar: 'str' }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: true' do
    let(:value) { { enabled: true } }
    it { should serialize_to enabled: true }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: false' do
    let(:value) { { enabled: false } }
    it { should serialize_to enabled: false }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: yes' do
    let(:value) { { enabled: true } }
    it { should serialize_to enabled: true }
    it { should_not have_msg }
  end

  describe 'given a map with enabled: no' do
    let(:value) { { enabled: false } }
    it { should serialize_to enabled: false }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: true' do
    let(:value) { { disabled: true } }
    it { should serialize_to enabled: false }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: false' do
    let(:value) { { disabled: false } }
    it { should serialize_to enabled: true }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: yes' do
    let(:value) { { disabled: true } }
    it { should serialize_to enabled: false }
    it { should_not have_msg }
  end

  describe 'given a map with disabled: no' do
    let(:value) { { disabled: false } }
    it { should serialize_to enabled: true }
    it { should_not have_msg }
  end

  describe 'given a map with :enabled it ignores :disabled' do
    describe 'enabled: true, disabled: true' do
      let(:value) { { enabled: true, disabled: true } }
      it { should serialize_to enabled: true }
      it { should_not have_msg }
    end

    describe 'enabled: true, disabled: false' do
      let(:value) { { enabled: true, disabled: false } }
      it { should serialize_to enabled: true }
      it { should_not have_msg }
    end

    describe 'enabled: false, disabled: true' do
      let(:value) { { enabled: false, disabled: true } }
      it { should serialize_to enabled: false }
      it { should_not have_msg }
    end

    describe 'enabled: false, disabled: false' do
      let(:value) { { enabled: false, disabled: false } }
      it { should serialize_to enabled: false }
      it { should_not have_msg }
    end
  end
end
