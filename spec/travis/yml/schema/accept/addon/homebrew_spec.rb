require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'homebrew' do
    describe 'update' do
      it { should validate addons: { homebrew: { update: true } } }

      it { should_not validate addons: { homebrew: { update: 1 } } }
      it { should_not validate addons: { homebrew: { update: 'str' } } }
      it { should_not validate addons: { homebrew: { update: ['str'] } } }
      it { should_not validate addons: { homebrew: { update: { name: 'str' } } } }
      it { should_not validate addons: { homebrew: { update: [ name: 'str' ] } } }
    end

    describe 'packages' do
      it { should validate addons: { homebrew: { packages: 'str' } } }
      it { should validate addons: { homebrew: { packages: ['str'] } } }

      it { should_not validate addons: { homebrew: { packages: 1 } } }
      it { should_not validate addons: { homebrew: { packages: true } } }
      it { should_not validate addons: { homebrew: { packages: { name: 'str' } } } }
      it { should_not validate addons: { homebrew: { packages: [ name: 'str' ] } } }
    end

    describe 'casks' do
      it { should validate addons: { homebrew: { casks: 'str' } } }
      it { should validate addons: { homebrew: { casks: ['str'] } } }

      it { should_not validate addons: { homebrew: { casks: 1 } } }
      it { should_not validate addons: { homebrew: { casks: true } } }
      it { should_not validate addons: { homebrew: { casks: { name: 'str' } } } }
      it { should_not validate addons: { homebrew: { casks: [ name: 'str' ] } } }
    end

    describe 'taps' do
      it { should validate addons: { homebrew: { taps: 'str' } } }
      it { should validate addons: { homebrew: { taps: ['str'] } } }

      it { should_not validate addons: { homebrew: { taps: 1 } } }
      it { should_not validate addons: { homebrew: { taps: true } } }
      it { should_not validate addons: { homebrew: { taps: { name: 'str' } } } }
      it { should_not validate addons: { homebrew: { taps: [ name: 'str' ] } } }
    end

    describe 'brewfile' do
      it { should validate addons: { homebrew: { brewfile: 'str' } } }

      it { should_not validate addons: { homebrew: { brewfile: 1 } } }
      it { should_not validate addons: { homebrew: { brewfile: true } } }
      it { should_not validate addons: { homebrew: { brewfile: ['str'] } } }
      it { should_not validate addons: { homebrew: { brewfile: { name: 'str' } } } }
      it { should_not validate addons: { homebrew: { brewfile: [ name: 'str' ] } } }
    end
  end
end
