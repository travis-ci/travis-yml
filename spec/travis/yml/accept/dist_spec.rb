describe Travis::Yml, 'dist' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'no default' do
    yaml ''
    it { should serialize_to empty }
  end

  known = %w(
    precise
    trusty
    xenial
  )

  known.each do |value|
    describe "given #{value}" do
      yaml %(
        dist: #{value}
      )
      it { should serialize_to dist: value }
      it { should_not have_msg }
    end
  end

  describe 'default', defaults: true do
    describe 'no os given', defaults: true do
      yaml ''
      it { should serialize_to os: ['linux'], dist: 'xenial', language: 'ruby' }
      it { should have_msg [:info, :root, :default, key: 'dist', default: 'xenial'] }
    end

    describe 'on linux', defaults: true do
      yaml %(
        os: linux
      )
      it { should serialize_to os: ['linux'], dist: 'xenial', language: 'ruby' }
      it { should have_msg [:info, :root, :default, key: 'dist', default: 'xenial'] }
    end

    describe 'on windows', defaults: true do
      yaml %(
        language: shell
        os: windows
      )
      it { should serialize_to os: ['windows'], language: 'shell' }
      it { should_not have_msg }
    end

    describe 'on oxs', defaults: true do
      yaml %(
        language: ruby
        os: osx
      )
      it { should serialize_to os: ['osx'], language: 'ruby' }
      it { should_not have_msg }
    end
  end

  describe 'ignores case' do
    yaml %(
      dist: TRUSTY
    )
    it { should serialize_to dist: 'trusty' }
    it { should have_msg [:info, :dist, :downcase, value: 'TRUSTY'] }
  end

  describe 'given an unknown value' do
    yaml %(
      dist: unknown
    )
    it { should serialize_to dist: 'xenial' }
    it { should have_msg [:warn, :dist, :unknown_default, value: 'unknown', default: 'xenial'] }
  end

  describe 'given a seq' do
    yaml %(
      dist:
      - trusty
    )
    it { should serialize_to dist: 'trusty' }
    it { should have_msg [:warn, :dist, :unexpected_seq, value: 'trusty'] }
  end

  describe 'unsupported on osx' do
    yaml %(
      os:
      - osx
      dist:
      - trusty
    )
    it { should serialize_to os: ['osx'], dist: 'trusty' }
    it { should have_msg [:warn, :dist, :unsupported, on_key: 'os', on_value: 'osx', key: 'dist', value: 'trusty'] }
  end
end
