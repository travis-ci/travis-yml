describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:ruby]) }

  describe 'ruby' do
    describe 'bundler_args' do
      it { should validate language: :ruby }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:ruby] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
