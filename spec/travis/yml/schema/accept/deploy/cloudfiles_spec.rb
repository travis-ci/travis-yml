describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:cloudfiles]) }

  describe 'cloudfiles' do
    describe 'username' do
      it { should validate deploy: { provider: :cloudfiles, username: 'str' } }
      it { should_not validate deploy: { provider: :cloudfiles, username: 1 } }
      it { should_not validate deploy: { provider: :cloudfiles, username: true } }
      it { should_not validate deploy: { provider: :cloudfiles, username: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfiles, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfiles, username: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :cloudfiles, api_key: 'str' } }
      it { should_not validate deploy: { provider: :cloudfiles, api_key: 1 } }
      it { should_not validate deploy: { provider: :cloudfiles, api_key: true } }
      it { should_not validate deploy: { provider: :cloudfiles, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfiles, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfiles, api_key: [{:foo=>'foo'}] } }
    end

    describe 'region' do
      it { should validate deploy: { provider: :cloudfiles, region: 'str' } }
      it { should_not validate deploy: { provider: :cloudfiles, region: 1 } }
      it { should_not validate deploy: { provider: :cloudfiles, region: true } }
      it { should_not validate deploy: { provider: :cloudfiles, region: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfiles, region: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfiles, region: [{:foo=>'foo'}] } }
    end

    describe 'container' do
      it { should validate deploy: { provider: :cloudfiles, container: 'str' } }
      it { should_not validate deploy: { provider: :cloudfiles, container: 1 } }
      it { should_not validate deploy: { provider: :cloudfiles, container: true } }
      it { should_not validate deploy: { provider: :cloudfiles, container: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfiles, container: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfiles, container: [{:foo=>'foo'}] } }
    end

    describe 'dot_match' do
      it { should validate deploy: { provider: :cloudfiles, dot_match: true } }
      it { should_not validate deploy: { provider: :cloudfiles, dot_match: 1 } }
      it { should_not validate deploy: { provider: :cloudfiles, dot_match: 'str' } }
      it { should_not validate deploy: { provider: :cloudfiles, dot_match: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfiles, dot_match: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfiles, dot_match: [{:foo=>'foo'}] } }
    end
  end
end
