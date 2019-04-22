describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:php]) }

  describe 'php' do
    describe 'composer_args' do
      it { should validate language: :php }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:php] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
