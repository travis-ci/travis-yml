describe Travis::Yml, 'matrix defaults', defaults: true do
  def self.expands_to(rows)
    it { expect(matrix.rows).to eq rows }
  end

  let(:data)   { {} }
  let(:config) { described_class.apply(parse(yaml), opts).serialize }
  let(:matrix) { described_class.matrix(config: config, data: data) }

  subject { matrix }

  describe 'os: linux' do
    yaml %(
      os: linux
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' }
    ]
  end

  describe 'os: unknown' do
    yaml %(
      os: unknown
    )
    expands_to [
      { language: 'ruby', os: 'unknown' }
    ]
  end

  describe 'os: [linux, osx, windows]' do
    yaml %(
      os:
      - linux
      - osx
      - windows
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' },
      { language: 'ruby', os: 'osx' }, # this should be objective-c, but it's not possible to make that happen with what we have at this point
      { language: 'ruby', os: 'windows' },
    ]
  end

  describe 'language: ruby on os: linux' do
    yaml %(
      language: ruby
      os: linux
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' }
    ]
  end

  describe 'language: ruby on os: [linux, osx, windows]' do
    yaml %(
      language: ruby
      os:
      - linux
      - osx
      - windows
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' },
      { language: 'ruby', os: 'osx' },
      { language: 'ruby', os: 'windows' },
    ]
  end

  describe 'language: python on os: [linux, osx, windows]' do
    yaml %(
      language: python
      os:
      - linux
      - osx
      - windows
    )
    expands_to [
      { language: 'python', os: 'linux', dist: 'focal' },
      { language: 'python', os: 'osx' },
      { language: 'python', os: 'windows' },
    ]
  end

  describe 'dist: focal' do
    yaml %(
      dist: focal
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' },
    ]
  end

  describe 'language: python, dist: focal' do
    yaml %(
      language: python
      dist: focal
    )
    expands_to [
      { language: 'python', os: 'linux', dist: 'focal' },
    ]
  end

  describe 'multi-os, dist: focal' do
    yaml %(
      os:
      - linux
      - osx
      - windows
      dist: focal
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' },
      { language: 'ruby', os: 'osx' },
      { language: 'ruby', os: 'windows' },
    ]
  end

  describe 'language: objective-c, dist, arch' do
    yaml %(
      language: objective-c
      dist: focal
      arch:
      - amd64
      - arm64
    )
    expands_to [
      { language: 'objective-c', os: 'osx' },
    ]
  end

  describe 'language: objective-c, osx_image' do
    yaml %(
      language: objective-c
      osx_image:
      - one
      - two
    )
    expands_to [
      { language: 'objective-c', os: 'osx', osx_image: 'one' },
      { language: 'objective-c', os: 'osx', osx_image: 'two' },
    ]
  end

  describe 'multi-os, osx_image' do
    yaml %(
      os:
      - linux
      - osx
      osx_image:
      - one
      - two
    )
    expands_to [
      { language: 'ruby', os: 'linux', dist: 'focal' },
      { language: 'ruby', os: 'osx', osx_image: 'one' },
      { language: 'ruby', os: 'osx', osx_image: 'two' },
    ]
  end

  describe 'multi-os, multi-arch' do
    yaml %(
      os:
      - linux
      - osx
      - windows
      arch:
      - amd64
      - arm64
    )
    expands_to [
      { language: 'ruby', os: 'linux', arch: 'amd64', dist: 'focal' },
      { language: 'ruby', os: 'linux', arch: 'arm64', dist: 'focal' },
      { language: 'ruby', os: 'osx' },
      { language: 'ruby', os: 'windows' },
    ]
  end

  describe 'multi-os, dist: focal, multi-arch' do
    yaml %(
      os:
      - linux
      - osx
      - windows
      arch:
      - amd64
      - arm64
      dist: focal
    )
    expands_to [
      { language: 'ruby', os: 'linux', arch: 'amd64', dist: 'focal' },
      { language: 'ruby', os: 'linux', arch: 'arm64', dist: 'focal' },
      { language: 'ruby', os: 'osx' },
      { language: 'ruby', os: 'windows' },
    ]
  end
end
