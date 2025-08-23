describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:r]) }

  describe 'r' do
    describe 'r_packages' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'r_binary_packages' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'r_github_packages' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'apt_packages' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'bioc_packages' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'brew_packages' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'bioc' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'bioc_check' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'bioc_required' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'bioc_use_devel' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'cran' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'disable_homebrew' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'latex' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'pandoc' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'pandoc_version' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'r_build_args' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'r_check_args' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'r_check_revdep' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'warnings_are_errors' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'remotes' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'repos' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
    describe 'use_devtools' do
      it { should validate language: :r }
      it { should_not validate language: 1 }
      it { should_not validate language: true }
      it { should_not validate language: [:r] }
      it { should_not validate language: {:foo=>'foo'} }
      it { should_not validate language: [{:foo=>'foo'}] }
    end
  end
end
