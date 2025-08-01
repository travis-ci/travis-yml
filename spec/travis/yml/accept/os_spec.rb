describe Travis::Yml do
  accept 'os' do
    describe 'defaults to linux', defaults: true do
      yaml ''
      it { should serialize_to defaults }
      it { should have_msg [:info, :root, :default, key: 'os', default: 'linux'] }
    end

    describe 'given multiple values', defaults: true do
      yaml %(
        os:
        - linux
        - osx
        - windows
      )
      it { should serialize_to language: 'ruby', os: ['linux', 'osx', 'windows'], dist: 'focal' }
    end

    describe 'given a string' do
      known = %w(
        linux
        osx
        windows
        freebsd
      )

      known.each do |value|
        describe "given #{value}" do
          yaml %(
            os: #{value}
          )
          it { should serialize_to os: [value] }
          it { should_not have_msg }
        end
      end

      describe 'an alias' do
        yaml %(
          os: ubuntu
        )
        it { should serialize_to os: ['linux'] }
      end

      describe 'downcases' do
        yaml %(
          os: LINUX
        )
        it { should serialize_to os: ['linux'] }
      end

      describe 'unknown', defaults: true do
        yaml %(
          os: unknown
        )
        xit { should serialize_to defaults }
        it { should have_msg [:error, :os, :unknown_value, value: 'unknown'] }
      end

      describe 'given deprecated linux-ppc64le' do
        yaml %(
          os: linux-ppc64le
        )
        it { should serialize_to os: ['linux-ppc64le'] }
        # it { should have_msg [:warn, :os, :deprecated_value, value: 'linux-ppc64le', info: 'use os: linux, arch: ppc64le'] }
      end
    end

    describe 'given a seq' do
      describe 'known' do
        yaml %(
          os:
          - linux
          - osx
          - freebsd
        )
        it { should serialize_to os: ['linux', 'osx', 'freebsd'] }
      end

      describe 'aliases' do
        yaml %(
          os:
          - ubuntu
          - macos
        )
        it { should serialize_to os: ['linux', 'osx'] }
      end

      describe 'downcases' do
        yaml %(
          os:
            - LINUX
            - OSX
            - FREEBSD
        )
        it { should serialize_to os: ['linux', 'osx', 'freebsd'] }
      end
    end

    describe 'given a mixed, nested seq', drop: true do
      yaml %(
        os:
        - linux
        - os: osx
      )
      let(:value) { { os: ['linux', os: 'osx'] } }
      it { should serialize_to os: ['linux'] }
      it { should have_msg [:error, :os, :invalid_type, expected: :str, actual: :map, value: { os: 'osx' }] }
    end

    describe 'defaults to osx for objective-c', defaults: true do
      yaml %(
        language: objective-c
      )
      it { should serialize_to language: 'objective-c', os: ['osx'] }
      it { should have_msg [:info, :root, :default, key: 'os', default: 'osx'] }
    end

    describe 'an os unsupported by the language' do
      yaml %(
        os: windows
        language: objective-c
      )
      it { should serialize_to language: 'objective-c',  os: ['windows'] }
      it { should have_msg [:warn, :os, :unsupported, on_key: 'language', on_value: 'objective-c', key: 'os', value: 'windows'] }
    end

    describe 'jdk on osx' do
      yaml %(
        os: osx
        language: java
        jdk: default
      )
      it { should serialize_to os: ['osx'], language: 'java', jdk: ['default'] }
      it { should_not have_msg }
    end

    describe 'given a mixed, nested seq, with an unsupported key on root', drop: true do
      yaml %(
        os:
        - linux
        - os: osx
        osx_image: str
      )
      it { should serialize_to os: ['linux'], osx_image: ['str'] }
      it { should have_msg [:error, :os, :invalid_type, expected: :str, actual: :map, value: { os: 'osx' }] }
      it { should have_msg [:warn, :osx_image, :unsupported, on_key: 'os', on_value: 'linux', key: 'osx_image', value: ['str']] }
    end
  end
end
