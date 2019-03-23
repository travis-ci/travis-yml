describe Travis::Yml, 'addon: code_climate' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a str' do
    yaml %(
      addons:
        code_climate: token
    )
    it { should serialize_to addons: { code_climate: { repo_token: 'token' } } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      addons:
        code_climate:
          secure: token
    )
    it { should serialize_to addons: { code_climate: { repo_token: { secure: 'token' } } } }
    it { should_not have_msg }
  end

  describe 'given a map with a str' do
    yaml %(
      addons:
        code_climate:
          repo_token: token
    )
    it { should serialize_to addons: { code_climate: { repo_token: 'token' } } }
    it { should_not have_msg }
  end

  describe 'given a map with a secure' do
    yaml %(
      addons:
        code_climate:
          repo_token:
            secure: token
    )
    it { should serialize_to addons: { code_climate: { repo_token: { secure: 'token' } } } }
    it { should_not have_msg }
  end
end
