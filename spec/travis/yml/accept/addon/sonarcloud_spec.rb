describe Travis::Yml, 'addon: sonarcloud' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given organization' do
    yaml %(
      addons:
        sonarcloud:
          organization: str
    )
    it { should serialize_to addons: { sonarcloud: { organization: 'str' } } }
    it { should_not have_msg }
  end

  describe 'given token (str)' do
    yaml %(
      addons:
        sonarcloud:
          token: str
    )
    it { should serialize_to addons: { sonarcloud: { token: 'str' } } }
    it { should_not have_msg }
  end

  describe 'given token (secure)' do
    yaml %(
      addons:
        sonarcloud:
          token:
            secure: str
    )
    it { should serialize_to addons: { sonarcloud: { token: { secure: 'str' } } } }
    it { should_not have_msg }
  end

  describe 'given branches (str)' do
    yaml %(
      addons:
        sonarcloud:
          branches: str
    )
    it { should serialize_to addons: { sonarcloud: { branches: ['str'] } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated, deprecation: :deprecated_sonarcloud_branches] }
  end

  describe 'given branches (seq of strs)' do
    yaml %(
      addons:
        sonarcloud:
          branches:
          - str
    )
    it { should serialize_to addons: { sonarcloud: { branches: ['str'] } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated, deprecation: :deprecated_sonarcloud_branches] }
  end

  describe 'given github_token (str)' do
    yaml %(
      addons:
        sonarcloud:
          github_token: str
    )
    it { should serialize_to addons: { sonarcloud: { github_token: 'str' } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated, deprecation: :deprecated_sonarcloud_github_token] }
  end

  describe 'given github_token (secure)' do
    yaml %(
      addons:
        sonarcloud:
          github_token:
            secure: str
    )
    it { should serialize_to addons: { sonarcloud: { github_token: { secure: 'str' } } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated, deprecation: :deprecated_sonarcloud_github_token] }
  end
end
