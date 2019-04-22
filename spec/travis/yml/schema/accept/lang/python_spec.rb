describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:python]) }

  describe 'python' do
    describe 'virtualenv' do
      it { should validate language: :python }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:python] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
