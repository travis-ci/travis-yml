require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }
  describe 'code_climate' do
    describe 'username' do
      it { should validate addons: { code_climate: { repo_token: 'str' } } }

      it { should_not validate addons: { code_climate: { repo_token: true } } }
      it { should_not validate addons: { code_climate: { repo_token: ['str'] } } }
      it { should_not validate addons: { code_climate: { repo_token: 1 } } }
      it { should_not validate addons: { code_climate: { repo_token: { name: 'str' } } } }
      it { should_not validate addons: { code_climate: { repo_token: [ name: 'str' ] } } }
    end
  end
end
