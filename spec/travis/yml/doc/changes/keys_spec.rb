describe Travis::Yml::Doc::Change::Keys do
  subject { described_class.new(build_schema(schema), build_value(value, opts)).apply }

  let(:schema) do
    {
      type: :object,
      properties: {
        sudo: {
          type: :boolean
        },
        foo_bar: {
          type: :boolean,
          aliases: [
            :foo
          ]
        }
      },
      additionalProperties: false
    }
  end

  describe 'given a known key' do
    let(:value) { { sudo: true } }
    it { should serialize_to sudo: true }
    it { should_not have_msg }
  end

  describe 'an unknown key with whitespace' do
    describe 'a space' do
      let(:value) { { ' sudo ': true } }
      it { should serialize_to sudo: true }
      it { should have_msg [:warn, :root, :strip_key, original: ' sudo ', key: 'sudo'] }
    end

    describe 'a tab' do
      let(:value) { { "\tsudo\t": true } }
      it { should serialize_to sudo: true }
      it { should have_msg [:warn, :root, :strip_key, original: "\tsudo\t", key: 'sudo'] }
    end

    describe 'a non breaking space' do
      let(:value) { { "\u00A0sudo\u00A0": true } }
      it { should serialize_to sudo: true }
      it { should have_msg [:warn, :root, :strip_key, original: "\u00A0sudo\u00A0", key: 'sudo'] }
    end
  end

  describe 'an unknown, dasherized key' do
    let(:value) { { 'foo-bar': true } }
    it { should serialize_to foo_bar: true }
    it { should have_msg [:info, :root, :underscore_key, original: 'foo-bar', key: 'foo_bar'] }
  end

  describe 'an unknown key with non-word chars' do
    let(:value) { { 'sudo?!': true } }
    it { should serialize_to sudo: true }
    it { should have_msg [:warn, :root, :clean_key, original: 'sudo?!', key: 'sudo'] }
  end

  describe 'an unknown key starting with an underscore' do
    let(:value) { { '_custom': true } }
    it { should serialize_to _custom: true }
    it { should_not have_msg }
  end

  describe 'an unknown key ending with an underscore' do
    let(:value) { { 'sudo_': true } }
    it { should serialize_to sudo: true }
    it { should have_msg [:warn, :root, :clean_key, original: 'sudo_', key: 'sudo'] }
  end

  describe 'an unknown key with two underscores' do
    let(:value) { { 'foo__bar': true } }
    it { should serialize_to foo_bar: true }
    it { should have_msg [:warn, :root, :clean_key, original: 'foo__bar', key: 'foo_bar'] }
  end

  describe 'an unknown key that is listed in the dictionary' do
    let(:value) { { asudo: true } }
    it { should serialize_to sudo: true }
    it { should have_msg [:warn, :root, :find_key, original: 'asudo', key: 'sudo'] }
  end

  describe 'an unknown key that can be matched to a known key' do
    let(:value) { { sudos: true } }
    it { should serialize_to sudo: true }
    it { should have_msg [:warn, :root, :find_key, original: 'sudos', key: 'sudo'] }
  end

  describe 'an alias to a known key' do
    let(:value) { { foo: true } }
    it { should serialize_to foo_bar: true }
    it { should have_msg [:info, :root, :alias_key, alias: 'foo', key: 'foo_bar'] }
  end

  describe 'adds a required key', defaults: true do
    let(:schema) do
      {
        type: :object,
        properties: {
          one: {
            type: :string
          }
        },
        required: [
          'one'
        ],
        additionalProperties: false
      }
    end

    let(:value) { {} }
    it { should serialize_to one: nil }
  end

  describe 'adds keys that have a default (no matter their support)', defaults: true do
    let(:schema) do
      {
        type: :object,
        properties: {
          one: {
            type: :string,
            defaults: [
              { value: 'one' }
            ]
          }
        },
        additionalProperties: false
      }
    end

    let(:value) { {} }
    it { should serialize_to one: nil }
  end
end
