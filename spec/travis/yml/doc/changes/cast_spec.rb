describe Travis::Yml::Doc::Change::Cast do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  describe 'a str' do
    let(:schema) { { type: :string } }

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to 'foo' }
      it { should_not have_msg }
    end

    describe 'given a number' do
      let(:value) { 1 }
      it { should serialize_to '1' }
      it { should have_msg [:info, :root, :cast, given_value: 1, given_type: :num, value: '1', type: :str] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to 'true' }
      it { should have_msg [:info, :root, :cast, given_value: true, given_type: :bool, value: 'true', type: :str] }
    end

    describe 'given a seq' do
      let(:value) { ['str'] }
      it { should serialize_to ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'a bool' do
    let(:schema) { { type: :boolean } }

    describe 'given "required"' do
      let(:value) { 'required' }
      it { should serialize_to true }
      it { should_not have_msg }
    end

    describe 'given "true"' do
      let(:value) { 'true' }
      it { should serialize_to true }
      it { should_not have_msg }
    end

    describe 'given "false"' do
      let(:value) { 'false' }
      it { should serialize_to false }
      it { should_not have_msg }
    end

    describe 'given a str' do
      let(:value) { 'str' }
      it { should serialize_to 'str' }
      it { should_not have_msg }
    end

    describe 'given a number' do
      let(:value) { 1 }
      it { should serialize_to 1 }
      it { should_not have_msg }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to true }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      let(:value) { ['str'] }
      it { should serialize_to ['str'] }
      it { should_not have_msg }
    end
  end
end
