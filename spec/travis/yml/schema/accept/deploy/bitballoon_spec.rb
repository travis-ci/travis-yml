describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:bitballoon]) }

  describe 'bitballoon' do
    describe 'access_token' do
      it { should validate deploy: { provider: :bitballoon, access_token: 'str' } }
      it { should_not validate deploy: { provider: :bitballoon, access_token: 1 } }
      it { should_not validate deploy: { provider: :bitballoon, access_token: true } }
      it { should_not validate deploy: { provider: :bitballoon, access_token: ['str'] } }
      it { should_not validate deploy: { provider: :bitballoon, access_token: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bitballoon, access_token: [{:foo=>'foo'}] } }
    end

    describe 'site_id' do
      it { should validate deploy: { provider: :bitballoon, site_id: 'str' } }
      it { should_not validate deploy: { provider: :bitballoon, site_id: 1 } }
      it { should_not validate deploy: { provider: :bitballoon, site_id: true } }
      it { should_not validate deploy: { provider: :bitballoon, site_id: ['str'] } }
      it { should_not validate deploy: { provider: :bitballoon, site_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bitballoon, site_id: [{:foo=>'foo'}] } }
    end

    describe 'local_dir' do
      it { should validate deploy: { provider: :bitballoon, local_dir: 'str' } }
      it { should_not validate deploy: { provider: :bitballoon, local_dir: 1 } }
      it { should_not validate deploy: { provider: :bitballoon, local_dir: true } }
      it { should_not validate deploy: { provider: :bitballoon, local_dir: ['str'] } }
      it { should_not validate deploy: { provider: :bitballoon, local_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bitballoon, local_dir: [{:foo=>'foo'}] } }
    end
  end
end
