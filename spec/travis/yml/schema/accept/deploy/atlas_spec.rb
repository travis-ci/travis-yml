describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:atlas]) }

  describe 'atlas' do
    describe 'token' do
      it { should validate deploy: { provider: :atlas, token: 'str' } }
      it { should_not validate deploy: { provider: :atlas, token: 1 } }
      it { should_not validate deploy: { provider: :atlas, token: true } }
      it { should_not validate deploy: { provider: :atlas, token: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, token: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, token: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :atlas, app: 'str' } }
      it { should_not validate deploy: { provider: :atlas, app: 1 } }
      it { should_not validate deploy: { provider: :atlas, app: true } }
      it { should_not validate deploy: { provider: :atlas, app: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, app: [{:foo=>'foo'}] } }
    end

    describe 'exclude' do
      it { should validate deploy: { provider: :atlas, exclude: 'str' } }
      it { should validate deploy: { provider: :atlas, exclude: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, exclude: 1 } }
      it { should_not validate deploy: { provider: :atlas, exclude: true } }
      it { should_not validate deploy: { provider: :atlas, exclude: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, exclude: [{:foo=>'foo'}] } }
    end

    describe 'include' do
      it { should validate deploy: { provider: :atlas, include: 'str' } }
      it { should validate deploy: { provider: :atlas, include: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, include: 1 } }
      it { should_not validate deploy: { provider: :atlas, include: true } }
      it { should_not validate deploy: { provider: :atlas, include: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, include: [{:foo=>'foo'}] } }
    end

    describe 'address' do
      it { should validate deploy: { provider: :atlas, address: 'str' } }
      it { should_not validate deploy: { provider: :atlas, address: 1 } }
      it { should_not validate deploy: { provider: :atlas, address: true } }
      it { should_not validate deploy: { provider: :atlas, address: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, address: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, address: [{:foo=>'foo'}] } }
    end

    describe 'vcs' do
      it { should validate deploy: { provider: :atlas, vcs: true } }
      it { should_not validate deploy: { provider: :atlas, vcs: 1 } }
      it { should_not validate deploy: { provider: :atlas, vcs: 'str' } }
      it { should_not validate deploy: { provider: :atlas, vcs: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, vcs: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, vcs: [{:foo=>'foo'}] } }
    end

    describe 'metadata' do
      it { should validate deploy: { provider: :atlas, metadata: 'str' } }
      it { should validate deploy: { provider: :atlas, metadata: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, metadata: 1 } }
      it { should_not validate deploy: { provider: :atlas, metadata: true } }
      it { should_not validate deploy: { provider: :atlas, metadata: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, metadata: [{:foo=>'foo'}] } }
    end

    describe 'debug' do
      it { should validate deploy: { provider: :atlas, debug: true } }
      it { should_not validate deploy: { provider: :atlas, debug: 1 } }
      it { should_not validate deploy: { provider: :atlas, debug: 'str' } }
      it { should_not validate deploy: { provider: :atlas, debug: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, debug: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, debug: [{:foo=>'foo'}] } }
    end

    describe 'version' do
      it { should validate deploy: { provider: :atlas, version: 'str' } }
      it { should_not validate deploy: { provider: :atlas, version: 1 } }
      it { should_not validate deploy: { provider: :atlas, version: true } }
      it { should_not validate deploy: { provider: :atlas, version: ['str'] } }
      it { should_not validate deploy: { provider: :atlas, version: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :atlas, version: [{:foo=>'foo'}] } }
    end
  end
end
