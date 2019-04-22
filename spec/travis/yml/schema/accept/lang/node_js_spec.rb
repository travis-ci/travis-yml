describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:node_js]) }

  describe 'node_js' do
    describe 'npm_args' do
      it { should validate language: :node_js }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:node_js] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
