require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'jwts' do
    describe 'username' do
      it { should validate addons: { jwt: 'str'  } }
      it { should validate addons: { jwt: ['str'] } }

      it { should_not validate addons: { jwt: true } }
      it { should_not validate addons: { jwt: 1 } }
      it { should_not validate addons: { jwt: { name: 'str' } } }
      it { should_not validate addons: { jwt: [ name: 'str' ] } }
    end
  end
end
