describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:boxfuse]) }

  describe 'boxfuse' do
    describe 'user' do
      it { should validate deploy: { provider: :boxfuse, user: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, user: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, user: true } }
      it { should_not validate deploy: { provider: :boxfuse, user: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, user: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, user: [{:foo=>'foo'}] } }
    end

    describe 'secret' do
      it { should validate deploy: { provider: :boxfuse, secret: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, secret: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, secret: true } }
      it { should_not validate deploy: { provider: :boxfuse, secret: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, secret: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, secret: [{:foo=>'foo'}] } }
    end

    describe 'configfile' do
      it { should validate deploy: { provider: :boxfuse, configfile: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, configfile: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, configfile: true } }
      it { should_not validate deploy: { provider: :boxfuse, configfile: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, configfile: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, configfile: [{:foo=>'foo'}] } }
    end

    describe 'payload' do
      it { should validate deploy: { provider: :boxfuse, payload: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, payload: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, payload: true } }
      it { should_not validate deploy: { provider: :boxfuse, payload: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, payload: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, payload: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :boxfuse, app: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, app: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, app: true } }
      it { should_not validate deploy: { provider: :boxfuse, app: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, app: [{:foo=>'foo'}] } }
    end

    describe 'version' do
      it { should validate deploy: { provider: :boxfuse, version: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, version: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, version: true } }
      it { should_not validate deploy: { provider: :boxfuse, version: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, version: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, version: [{:foo=>'foo'}] } }
    end

    describe 'env' do
      it { should validate deploy: { provider: :boxfuse, env: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, env: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, env: true } }
      it { should_not validate deploy: { provider: :boxfuse, env: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, env: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, env: [{:foo=>'foo'}] } }
    end

    describe 'image' do
      it { should validate deploy: { provider: :boxfuse, image: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, image: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, image: true } }
      it { should_not validate deploy: { provider: :boxfuse, image: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, image: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, image: [{:foo=>'foo'}] } }
    end

    describe 'extra_args' do
      it { should validate deploy: { provider: :boxfuse, extra_args: 'str' } }
      it { should_not validate deploy: { provider: :boxfuse, extra_args: 1 } }
      it { should_not validate deploy: { provider: :boxfuse, extra_args: true } }
      it { should_not validate deploy: { provider: :boxfuse, extra_args: ['str'] } }
      it { should_not validate deploy: { provider: :boxfuse, extra_args: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :boxfuse, extra_args: [{:foo=>'foo'}] } }
    end
  end
end
