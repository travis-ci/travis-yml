describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:chef_supermarket]) }

  describe 'chef_supermarket' do
    describe 'user_id' do
      it { should validate deploy: { provider: :chef_supermarket, user_id: 'str' } }
      it { should_not validate deploy: { provider: :chef_supermarket, user_id: 1 } }
      it { should_not validate deploy: { provider: :chef_supermarket, user_id: true } }
      it { should_not validate deploy: { provider: :chef_supermarket, user_id: ['str'] } }
      it { should_not validate deploy: { provider: :chef_supermarket, user_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :chef_supermarket, user_id: [{:foo=>'foo'}] } }
    end

    describe 'client_key' do
      it { should validate deploy: { provider: :chef_supermarket, client_key: 'str' } }
      it { should_not validate deploy: { provider: :chef_supermarket, client_key: 1 } }
      it { should_not validate deploy: { provider: :chef_supermarket, client_key: true } }
      it { should_not validate deploy: { provider: :chef_supermarket, client_key: ['str'] } }
      it { should_not validate deploy: { provider: :chef_supermarket, client_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :chef_supermarket, client_key: [{:foo=>'foo'}] } }
    end

    describe 'cookbook_category' do
      it { should validate deploy: { provider: :chef_supermarket, cookbook_category: 'str' } }
      it { should_not validate deploy: { provider: :chef_supermarket, cookbook_category: 1 } }
      it { should_not validate deploy: { provider: :chef_supermarket, cookbook_category: true } }
      it { should_not validate deploy: { provider: :chef_supermarket, cookbook_category: ['str'] } }
      it { should_not validate deploy: { provider: :chef_supermarket, cookbook_category: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :chef_supermarket, cookbook_category: [{:foo=>'foo'}] } }
    end
  end
end
