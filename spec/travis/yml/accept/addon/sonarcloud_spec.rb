describe Travis::Yml, 'addon: sonarcloud' do
  subject { described_class.load(yaml) }

  describe 'given true' do
    yaml %(
      addons:
        sonarcloud: true
    )
    it { should serialize_to addons: { sonarcloud: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given enabled' do
    yaml %(
      addons:
        sonarcloud:
          enabled: true
    )
    it { should serialize_to addons: { sonarcloud: { enabled: true } } }
    it { should_not have_msg }
  end

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
            secure: #{secure}
    )
    it { should serialize_to addons: { sonarcloud: { token: { secure: secure } } } }
    it { should_not have_msg }
  end

  describe 'given branches (str)' do
    yaml %(
      addons:
        sonarcloud:
          branches: str
    )
    it { should serialize_to addons: { sonarcloud: { branches: ['str'] } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'branches', info: 'setting a branch is deprecated'] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given branches (seq of strs)' do
    yaml %(
      addons:
        sonarcloud:
          branches:
          - str
    )
    it { should serialize_to addons: { sonarcloud: { branches: ['str'] } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'branches', info: 'setting a branch is deprecated'] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given github_token (str)' do
    yaml %(
      addons:
        sonarcloud:
          github_token: str
    )
    it { should serialize_to addons: { sonarcloud: { github_token: 'str' } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'github_token', info: 'setting a GitHub token is deprecated'] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given github_token (secure)' do
    yaml %(
      addons:
        sonarcloud:
          github_token:
            secure: #{secure}
    )
    it { should serialize_to addons: { sonarcloud: { github_token: { secure: secure } } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'github_token', info: 'setting a GitHub token is deprecated'] }
    it { expect(msgs.size).to eq 1 }
  end
end
