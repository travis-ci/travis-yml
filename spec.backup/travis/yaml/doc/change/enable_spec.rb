describe Travis::Yaml::Doc::Change::Enable do
  let(:email) { subject.raw[:notifications][:email] }

  subject { change(build(nil, :root, { notifications: { email: value } }, {})) }

  describe 'given true' do
    let(:value) { true }
    it { expect(email).to eq enabled: true }
  end

  describe 'given false' do
    let(:value) { false }
    it { expect(email).to eq enabled: false }
  end

  describe 'given an empty hash' do
    let(:value) { {} }
    it { expect(email).to eq({}) }
  end

  describe 'given a non-empty hash without an :enabled key' do
    let(:value) { { foo: :foo } }
    it { expect(email).to eq enabled: true, foo: :foo }
  end

  describe 'given a hash with enabled: true' do
    let(:value) { { enabled: true } }
    it { expect(email).to eq enabled: true }
  end

  describe 'given a hash with enabled: false' do
    let(:value) { { enabled: false } }
    it { expect(email).to eq enabled: false }
  end

  describe 'given a hash with disabled: true' do
    let(:value) { { disabled: true } }
    it { expect(email).to eq enabled: false }
  end

  describe 'given a hash with disabled: false' do
    let(:value) { { disabled: false } }
    it { expect(email).to eq enabled: true }
  end
end
