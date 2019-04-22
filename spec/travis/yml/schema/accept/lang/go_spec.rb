describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:go]) }

  describe 'go' do
    describe 'gobuild_args' do
      it { should validate language: :go }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:go] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'go_import_path' do
      it { should validate language: :go }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:go] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'gimme_config' do
      it { should validate language: :go }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:go] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
