require 'json'

describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'snaps' do
    describe 'given a single value' do
      it { should validate addons: { snaps: 'str' } }
      it { should validate addons: { snaps: ['str'] } }
      it { should validate addons: { snaps: { name: 'str', classic: true, channel: 'str' } } }
      it { should validate addons: { snaps: [ name: 'str', classic: true, channel: 'str' ] } }

      it { should_not validate addons: { snaps: true } }
      it { should_not validate addons: { snaps: 1 } }

      it { should_not validate addons: { snaps: [true] } }
      it { should_not validate addons: { snaps: [1] } }

      it { should_not validate addons: { snaps: { name: true } } }
      it { should_not validate addons: { snaps: { classic: 'str' } } }
      it { should_not validate addons: { snaps: { channel: 1 } } }

      it { should_not validate addons: { snaps: [ name: true ] } }
      it { should_not validate addons: { snaps: [ classic: 'str' ] } }
      it { should_not validate addons: { snaps: [ channel: 1 ] } }
    end
  end
end
