describe Travis::Yml, 'cache', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given true on apt' do
    yaml %(
      cache:
        apt: true
    )
    it { should serialize_to cache: { apt: true } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs on directories' do
    yaml %(
      cache:
        directories:
          - str
    )
    it { should serialize_to cache: { directories: ['str'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and bundler' do
    yaml %(
      cache:
        - apt
        - bundler
    )
    let(:value) { { cache: [:apt, :bundler] } }
    it { should serialize_to cache: { apt: true, bundler: true } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and directories' do
    yaml %(
      cache:
        - apt
        - directories:
          - str
    )
    let(:value) { { cache: [:apt, directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown str' do
    yaml %(
      cache:
        - apt
        - unknown
        - directories:
          - str
    )
    let(:value) { { cache: [:apt, :unknown, directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str', 'unknown'] } }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown str in a seq' do
    yaml %(
      cache:
        - apt
        -
          - unknown
        - directories:
          - str
    )
    let(:value) { { cache: [:apt, [:unknown], directories: ['str']] } }
    it { should serialize_to cache: { apt: true, directories: ['str'] } }
    # rewrite Change::Cache to not drop unexpected things
    xit { should have_msg [:warn, :'cache.directories', :unexpected_seq, value: 'unknown'] }
  end

  describe 'given a seq with apt, directories, and an unknown key with a str' do
    yaml %(
      cache:
        - apt
        - directories:
          - str
          unknown: str
    )
    let(:value) { { cache: [:apt, directories: ['str'], unknown: 'str'] } }
    it { should serialize_to cache: { unknown: 'str', apt: true, directories: ['str'] } }
    it { should have_msg [:warn, :cache, :unknown_key, key: 'unknown', value: 'str', line: 5] }
  end

  describe 'given a seq with a map on directories', drop: true do
    yaml %(
      cache:
        directories:
          - str
          - foo: str
    )
    it { should serialize_to cache: { directories: ['str'] } }
    it { should have_msg [:error, :'cache.directories', :invalid_type, expected: :str, actual: :map, value: { foo: 'str' }, line: 2] }
  end
end
