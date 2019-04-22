describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:'objective-c']) }

  describe 'objective-c' do
    describe 'podfile' do
      it { should validate language: :'objective-c' }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:'objective-c'] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'bundler_args' do
      it { should validate language: :'objective-c' }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:'objective-c'] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'xcode_project' do
      it { should validate language: :'objective-c' }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:'objective-c'] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'xcode_workspace' do
      it { should validate language: :'objective-c' }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:'objective-c'] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'xctool_args' do
      it { should validate language: :'objective-c' }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:'objective-c'] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
