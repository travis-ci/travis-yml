describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:scala]) }

  describe 'scala' do
    describe 'sbt_args' do
      it { should validate language: :scala }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:scala] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
