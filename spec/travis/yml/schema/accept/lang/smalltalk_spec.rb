describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:smalltalk]) }

  describe 'smalltalk' do
    describe 'smalltalk_config' do
      it { should validate language: :smalltalk }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:smalltalk] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'smalltalk_edge' do
      it { should validate language: :smalltalk }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:smalltalk] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
