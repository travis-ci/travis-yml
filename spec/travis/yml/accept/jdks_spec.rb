describe Travis::Yml, 'jdk' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'on linux, ruby, jruby' do
    yaml %(
      language: ruby
      os:
      - linux
      jdk: default
    )
    it { should serialize_to language: 'ruby', os: ['linux'], jdk: ['default'] }
    it { should_not have_msg }
  end

  describe 'on multios' do
    yaml %(
      language: ruby
      os:
      - linux
      - osx
      jdk: default
    )

    it { should serialize_to language: 'ruby', os: ['linux', 'osx'], jdk: ['default'] }
    it { should_not have_msg }
  end

  describe 'on osx' do
    yaml %(
      language: ruby
      os: osx
      jdk: default
    )
    it { should serialize_to language: 'ruby', os: ['osx'], jdk: ['default'] }
    it { should_not have_msg }
  end
end
