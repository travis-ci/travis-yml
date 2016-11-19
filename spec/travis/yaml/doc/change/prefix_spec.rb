describe Travis::Yaml::Doc::Change::Prefix do
  let(:result) { subject.raw }

  subject { change(build(nil, :root, value, {})) }

  describe 'on :env (no conditions)' do
    let(:env) { result[:env] }

    describe 'accepts a bool' do
      let(:value) { { env: true } }
      it { expect(env).to eq matrix: ['true'] } # that's bullshit, innit?
    end

    describe 'accepts a string' do
      let(:value) { { env: 'foo' } }
      it { expect(env).to eq matrix: ['foo'] }
    end

    describe 'accepts an array' do
      let(:value) { { env: ['foo'] } }
      it { expect(env).to eq matrix: ['foo'] }
    end

    describe 'accepts a hash' do
      let(:value) { { env: { foo: :foo} } }
      it { expect(env).to eq matrix: ['foo=foo'] }
    end

    describe 'accepts a prefixed hash' do
      let(:value)  { { env: { matrix: :foo } } }
      it { expect(env).to eq matrix: [:foo] }
    end
  end

  describe 'on :deploy (type: :scalar)' do
    let(:deploy) { result[:deploy] }

    describe 'accepts a bool' do
      let(:value) { { deploy: true } }
      it { expect(deploy).to eq [true] }
    end

    describe 'accepts a string' do
      let(:value) { { deploy: 's3' } }
      it { expect(deploy).to eq [provider: 's3'] }
    end

    describe 'accepts an array' do
      let(:value) { { deploy: ['s3'] } }
      it { expect(deploy).to eq [provider: 's3'] }
    end

    describe 'accepts a hash' do
      let(:value) { { deploy: { foo: 'foo' } } }
      it { expect(deploy).to eq [provider: nil, foo: 'foo'] }
    end

    describe 'rejects a prefixed hash' do
      let(:value) { { deploy: { provider: 's3' } } }
      it { expect(deploy).to eq [provider: 's3'] }
    end

    describe 'rejects a secure' do
      let(:value) { { deploy: { secure: 'secure' } } }
      it { expect(deploy).to eq [secure: 'secure'] }
    end
  end

  describe 'on :deploy (type: :bool)' do
    let(:notifications) { result[:notifications] }

    describe 'accepts a bool' do
      let(:value) { { notifications: true } }
      it { expect(notifications).to eq email: { enabled: true } }
    end

    describe 'rejects a string' do
      let(:value) { { notifications: 'foo' } }
      it { expect(notifications).to eq 'foo' }
    end

    describe 'rejects an array' do
      let(:value) { { notifications: ['foo'] } }
      it { expect(notifications).to eq 'foo' } # wat?
    end

    describe 'rejects a hash (rejected)' do
      let(:value) { { notifications: { foo: 'foo' } } }
      it { expect(notifications).to eq foo: 'foo' }
    end

    describe 'rejects a prefixed hash' do
      let(:value) { { notifications: { campfire: true } } }
      it { expect(notifications).to eq campfire: { enabled: true } }
    end

    describe 'rejects a secure' do
      let(:value) { { notifications: { secure: 'secure' } } }
      it { expect(notifications).to eq secure: 'secure' }
    end
  end

  describe 'on :campfire (type: [:scalar, :secure, :seq])' do
    let(:campfire) { result[:notifications][:campfire] }

    describe 'accepts a bool' do
      let(:value) { { notifications: { campfire: true } } }
      it { expect(campfire).to eq enabled: true }
    end

    describe 'accepts a string' do
      let(:value) { { notifications: { campfire: 'room' } } }
      it { expect(campfire).to eq rooms: ['room'], enabled: true }
    end

    describe 'accepts an array' do
      let(:value) { { notifications: { campfire: ['room'] } } }
      it { expect(campfire).to eq rooms: ['room'], enabled: true }
    end

    describe 'rejects a hash' do
      let(:value) { { notifications: { campfire: { foo: 'foo' } } } }
      it { expect(campfire).to eq foo: 'foo', enabled: true }
    end

    describe 'accepts a prefixed hash' do
      let(:value) { { notifications: { campfire: { rooms: 'room' } } } }
      it { expect(campfire).to eq rooms: ['room'], enabled: true }
    end

    describe 'accepts a secure' do
      let(:value) { { notifications: { campfire: { secure: 'secure' } } } }
      it { expect(campfire).to eq rooms: [{ secure: 'secure' }], enabled: true }
    end
  end
end
