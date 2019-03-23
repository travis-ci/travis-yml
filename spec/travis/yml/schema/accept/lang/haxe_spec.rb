describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:haxe]) }

  describe 'haxe' do
    describe 'hxml' do
      it { should validate language: :haxe }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:haxe] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'neko' do
      it { should validate language: :haxe }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:haxe] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
