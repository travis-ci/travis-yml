describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:gae]) }

  describe 'gae' do
    describe 'project' do
      it { should validate deploy: { provider: :gae, project: 'str' } }
      it { should_not validate deploy: { provider: :gae, project: 1 } }
      it { should_not validate deploy: { provider: :gae, project: true } }
      it { should_not validate deploy: { provider: :gae, project: ['str'] } }
      it { should_not validate deploy: { provider: :gae, project: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, project: [{:foo=>'foo'}] } }
    end

    describe 'keyfile' do
      it { should validate deploy: { provider: :gae, keyfile: 'str' } }
      it { should_not validate deploy: { provider: :gae, keyfile: 1 } }
      it { should_not validate deploy: { provider: :gae, keyfile: true } }
      it { should_not validate deploy: { provider: :gae, keyfile: ['str'] } }
      it { should_not validate deploy: { provider: :gae, keyfile: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, keyfile: [{:foo=>'foo'}] } }
    end

    describe 'config' do
      it { should validate deploy: { provider: :gae, config: 'str' } }
      it { should_not validate deploy: { provider: :gae, config: 1 } }
      it { should_not validate deploy: { provider: :gae, config: true } }
      it { should_not validate deploy: { provider: :gae, config: ['str'] } }
      it { should_not validate deploy: { provider: :gae, config: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, config: [{:foo=>'foo'}] } }
    end

    describe 'version' do
      it { should validate deploy: { provider: :gae, version: 'str' } }
      it { should_not validate deploy: { provider: :gae, version: 1 } }
      it { should_not validate deploy: { provider: :gae, version: true } }
      it { should_not validate deploy: { provider: :gae, version: ['str'] } }
      it { should_not validate deploy: { provider: :gae, version: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, version: [{:foo=>'foo'}] } }
    end

    describe 'no_promote' do
      it { should validate deploy: { provider: :gae, no_promote: true } }
      it { should_not validate deploy: { provider: :gae, no_promote: 1 } }
      it { should_not validate deploy: { provider: :gae, no_promote: 'str' } }
      it { should_not validate deploy: { provider: :gae, no_promote: ['str'] } }
      it { should_not validate deploy: { provider: :gae, no_promote: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, no_promote: [{:foo=>'foo'}] } }
    end

    describe 'no_stop_previous_version' do
      it { should validate deploy: { provider: :gae, no_stop_previous_version: true } }
      it { should_not validate deploy: { provider: :gae, no_stop_previous_version: 1 } }
      it { should_not validate deploy: { provider: :gae, no_stop_previous_version: 'str' } }
      it { should_not validate deploy: { provider: :gae, no_stop_previous_version: ['str'] } }
      it { should_not validate deploy: { provider: :gae, no_stop_previous_version: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, no_stop_previous_version: [{:foo=>'foo'}] } }
    end

    describe 'verbosity' do
      it { should validate deploy: { provider: :gae, verbosity: 'str' } }
      it { should_not validate deploy: { provider: :gae, verbosity: 1 } }
      it { should_not validate deploy: { provider: :gae, verbosity: true } }
      it { should_not validate deploy: { provider: :gae, verbosity: ['str'] } }
      it { should_not validate deploy: { provider: :gae, verbosity: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gae, verbosity: [{:foo=>'foo'}] } }
    end
  end
end
