describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:elm]) }

  describe 'elm' do
    describe 'elm_format' do
      it { should validate language: :elm }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:elm] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'elm_test' do
      it { should validate language: :elm }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:elm] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
