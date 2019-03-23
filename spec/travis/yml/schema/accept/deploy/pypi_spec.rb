describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:pypi]) }

  describe 'pypi' do
    describe 'user' do
      it { should validate deploy: { provider: :pypi, user: 'str' } }
      it { should_not validate deploy: { provider: :pypi, user: 1 } }
      it { should_not validate deploy: { provider: :pypi, user: true } }
      it { should_not validate deploy: { provider: :pypi, user: ['str'] } }
      it { should_not validate deploy: { provider: :pypi, user: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pypi, user: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :pypi, password: 'str' } }
      it { should_not validate deploy: { provider: :pypi, password: 1 } }
      it { should_not validate deploy: { provider: :pypi, password: true } }
      it { should_not validate deploy: { provider: :pypi, password: ['str'] } }
      it { should_not validate deploy: { provider: :pypi, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pypi, password: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :pypi, api_key: 'str' } }
      it { should_not validate deploy: { provider: :pypi, api_key: 1 } }
      it { should_not validate deploy: { provider: :pypi, api_key: true } }
      it { should_not validate deploy: { provider: :pypi, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :pypi, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pypi, api_key: [{:foo=>'foo'}] } }
    end

    describe 'server' do
      it { should validate deploy: { provider: :pypi, server: 'str' } }
      it { should_not validate deploy: { provider: :pypi, server: 1 } }
      it { should_not validate deploy: { provider: :pypi, server: true } }
      it { should_not validate deploy: { provider: :pypi, server: ['str'] } }
      it { should_not validate deploy: { provider: :pypi, server: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pypi, server: [{:foo=>'foo'}] } }
    end

    describe 'distributions' do
      it { should validate deploy: { provider: :pypi, distributions: 'str' } }
      it { should_not validate deploy: { provider: :pypi, distributions: 1 } }
      it { should_not validate deploy: { provider: :pypi, distributions: true } }
      it { should_not validate deploy: { provider: :pypi, distributions: ['str'] } }
      it { should_not validate deploy: { provider: :pypi, distributions: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pypi, distributions: [{:foo=>'foo'}] } }
    end

    describe 'docs_dir' do
      it { should validate deploy: { provider: :pypi, docs_dir: 'str' } }
      it { should_not validate deploy: { provider: :pypi, docs_dir: 1 } }
      it { should_not validate deploy: { provider: :pypi, docs_dir: true } }
      it { should_not validate deploy: { provider: :pypi, docs_dir: ['str'] } }
      it { should_not validate deploy: { provider: :pypi, docs_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pypi, docs_dir: [{:foo=>'foo'}] } }
    end
  end
end
