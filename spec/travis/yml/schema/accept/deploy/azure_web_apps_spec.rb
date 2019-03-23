describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:azure_web_apps]) }

  describe 'azure_web_apps' do
    describe 'site' do
      it { should validate deploy: { provider: :azure_web_apps, site: 'str' } }
      it { should_not validate deploy: { provider: :azure_web_apps, site: 1 } }
      it { should_not validate deploy: { provider: :azure_web_apps, site: true } }
      it { should_not validate deploy: { provider: :azure_web_apps, site: ['str'] } }
      it { should_not validate deploy: { provider: :azure_web_apps, site: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :azure_web_apps, site: [{:foo=>'foo'}] } }
    end

    describe 'slot' do
      it { should validate deploy: { provider: :azure_web_apps, slot: 'str' } }
      it { should_not validate deploy: { provider: :azure_web_apps, slot: 1 } }
      it { should_not validate deploy: { provider: :azure_web_apps, slot: true } }
      it { should_not validate deploy: { provider: :azure_web_apps, slot: ['str'] } }
      it { should_not validate deploy: { provider: :azure_web_apps, slot: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :azure_web_apps, slot: [{:foo=>'foo'}] } }
    end

    describe 'username' do
      it { should validate deploy: { provider: :azure_web_apps, username: 'str' } }
      it { should_not validate deploy: { provider: :azure_web_apps, username: 1 } }
      it { should_not validate deploy: { provider: :azure_web_apps, username: true } }
      it { should_not validate deploy: { provider: :azure_web_apps, username: ['str'] } }
      it { should_not validate deploy: { provider: :azure_web_apps, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :azure_web_apps, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :azure_web_apps, password: 'str' } }
      it { should_not validate deploy: { provider: :azure_web_apps, password: 1 } }
      it { should_not validate deploy: { provider: :azure_web_apps, password: true } }
      it { should_not validate deploy: { provider: :azure_web_apps, password: ['str'] } }
      it { should_not validate deploy: { provider: :azure_web_apps, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :azure_web_apps, password: [{:foo=>'foo'}] } }
    end

    describe 'verbose' do
      it { should validate deploy: { provider: :azure_web_apps, verbose: true } }
      it { should_not validate deploy: { provider: :azure_web_apps, verbose: 1 } }
      it { should_not validate deploy: { provider: :azure_web_apps, verbose: 'str' } }
      it { should_not validate deploy: { provider: :azure_web_apps, verbose: ['str'] } }
      it { should_not validate deploy: { provider: :azure_web_apps, verbose: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :azure_web_apps, verbose: [{:foo=>'foo'}] } }
    end
  end
end
