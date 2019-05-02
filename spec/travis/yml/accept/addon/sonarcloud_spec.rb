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
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'branches', info: 'not supported any more'] }
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
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'branches', info: 'not supported any more'] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given github_token (str)' do
    yaml %(
      addons:
        sonarcloud:
          github_token: str
    )
    it { should serialize_to addons: { sonarcloud: { github_token: 'str' } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'github_token', info: 'not supported any more'] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given github_token (secure)' do
    yaml %(
      addons:
        sonarcloud:
          github_token:
            secure: str
    )
    it { should serialize_to addons: { sonarcloud: { github_token: { secure: 'str' } } } }
    it { should have_msg [:warn, :'addons.sonarcloud', :deprecated_key, key: 'github_token', info: 'not supported any more'] }
    it { expect(msgs.size).to eq 1 }
  end
end
