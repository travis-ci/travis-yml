describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:bintray]) }

  describe 'bintray' do
    describe 'file' do
      it { should validate deploy: { provider: :bintray, file: 'str' } }
      it { should_not validate deploy: { provider: :bintray, file: 1 } }
      it { should_not validate deploy: { provider: :bintray, file: true } }
      it { should_not validate deploy: { provider: :bintray, file: ['str'] } }
      it { should_not validate deploy: { provider: :bintray, file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bintray, file: [{:foo=>'foo'}] } }
    end

    describe 'user' do
      it { should validate deploy: { provider: :bintray, user: 'str' } }
      it { should_not validate deploy: { provider: :bintray, user: 1 } }
      it { should_not validate deploy: { provider: :bintray, user: true } }
      it { should_not validate deploy: { provider: :bintray, user: ['str'] } }
      it { should_not validate deploy: { provider: :bintray, user: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bintray, user: [{:foo=>'foo'}] } }
    end

    describe 'key' do
      it { should validate deploy: { provider: :bintray, key: 'str' } }
      it { should_not validate deploy: { provider: :bintray, key: 1 } }
      it { should_not validate deploy: { provider: :bintray, key: true } }
      it { should_not validate deploy: { provider: :bintray, key: ['str'] } }
      it { should_not validate deploy: { provider: :bintray, key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bintray, key: [{:foo=>'foo'}] } }
    end

    describe 'passphrase' do
      it { should validate deploy: { provider: :bintray, passphrase: 'str' } }
      it { should_not validate deploy: { provider: :bintray, passphrase: 1 } }
      it { should_not validate deploy: { provider: :bintray, passphrase: true } }
      it { should_not validate deploy: { provider: :bintray, passphrase: ['str'] } }
      it { should_not validate deploy: { provider: :bintray, passphrase: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bintray, passphrase: [{:foo=>'foo'}] } }
    end

    describe 'dry_run' do
      it { should validate deploy: { provider: :bintray, dry_run: true } }
      it { should_not validate deploy: { provider: :bintray, dry_run: 1 } }
      it { should_not validate deploy: { provider: :bintray, dry_run: 'str' } }
      it { should_not validate deploy: { provider: :bintray, dry_run: ['str'] } }
      it { should_not validate deploy: { provider: :bintray, dry_run: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bintray, dry_run: [{:foo=>'foo'}] } }
    end
  end
end
