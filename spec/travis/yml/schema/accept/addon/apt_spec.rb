require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'apt' do
    describe 'packages' do
      it { should validate addons: { apt: { packages: 'curl' } } }
      it { should validate addons: { apt: { packages: ['curl'] } } }

      it { should_not validate addons: { apt: { packages: 1 } } }
      it { should_not validate addons: { apt: { packages: true } } }
      it { should_not validate addons: { apt: { packages: { name: 'curl' } } } }
      it { should_not validate addons: { apt: { packages: [ name: 'curl' ] } } }
    end

    describe 'sources' do
      it { should validate addons: { apt: { sources: 'curl' } } }
      it { should validate addons: { apt: { sources: ['curl'] } } }
      it { should validate addons: { apt: { sources: { name: 'curl' } } } }
      it { should validate addons: { apt: { sources: [ name: 'curl' ] } } }

      it { should_not validate addons: { apt: { sources: 1 } } }
      it { should_not validate addons: { apt: { sources: true } } }
    end

    describe 'dist' do
      it { should validate addons: { apt: { dist: 'precise' } } }
      it { should validate addons: { apt: { dist: 'xenial' } } }

      it { should_not validate addons: { apt: { dist: 'not-a-dist' } } }
      it { should_not validate addons: { apt: { dist: ['precise'] } } }
      it { should_not validate addons: { apt: { dist: [name: 'precise'] } } }
    end
  end
end
