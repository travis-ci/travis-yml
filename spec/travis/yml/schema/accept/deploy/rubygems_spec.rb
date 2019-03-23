describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:rubygems]) }

  describe 'rubygems' do
    describe 'gem' do
      it { should validate deploy: { provider: :rubygems, gem: 'str' } }
      it { should_not validate deploy: { provider: :rubygems, gem: 1 } }
      it { should_not validate deploy: { provider: :rubygems, gem: true } }
      it { should_not validate deploy: { provider: :rubygems, gem: ['str'] } }
      it { should_not validate deploy: { provider: :rubygems, gem: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :rubygems, gem: [{:foo=>'foo'}] } }
    end

    describe 'file' do
      it { should validate deploy: { provider: :rubygems, file: 'str' } }
      it { should_not validate deploy: { provider: :rubygems, file: 1 } }
      it { should_not validate deploy: { provider: :rubygems, file: true } }
      it { should_not validate deploy: { provider: :rubygems, file: ['str'] } }
      it { should_not validate deploy: { provider: :rubygems, file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :rubygems, file: [{:foo=>'foo'}] } }
    end

    describe 'gemspec' do
      it { should validate deploy: { provider: :rubygems, gemspec: 'str' } }
      it { should_not validate deploy: { provider: :rubygems, gemspec: 1 } }
      it { should_not validate deploy: { provider: :rubygems, gemspec: true } }
      it { should_not validate deploy: { provider: :rubygems, gemspec: ['str'] } }
      it { should_not validate deploy: { provider: :rubygems, gemspec: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :rubygems, gemspec: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :rubygems, api_key: 'str' } }
      it { should_not validate deploy: { provider: :rubygems, api_key: 1 } }
      it { should_not validate deploy: { provider: :rubygems, api_key: true } }
      it { should_not validate deploy: { provider: :rubygems, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :rubygems, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :rubygems, api_key: [{:foo=>'foo'}] } }
    end
  end
end
