describe Travis::Yml::Doc::Validate, 'default', defaults: true, line: true do
  subject { Travis::Yml.apply(parse(yaml), opts) }

  describe 'language, os, dist' do
    describe 'given a str' do
      yaml 'language: ruby'
      it { should serialize_to defaults }
      it { should_not have_msg [:info, :language, :default, key: 'language', default: 'ruby'] }
      it { should have_msg [:info, :os, :default, key: 'os', default: 'linux'] }
    end

    describe 'given an empty string' do
      yaml 'language: ""'
      it { should serialize_to defaults }
      it { should have_msg [:info, :language, :default, key: 'language', default: 'ruby'] }
    end

    describe 'given nil' do
      yaml 'language:'
      it { should serialize_to defaults }
      it { should have_msg [:info, :language, :default, key: 'language', default: 'ruby'] }
    end

    describe 'missing key' do
      yaml '{}'
      it { should serialize_to defaults }
      it { should have_msg [:info, :language, :default, key: 'language', default: 'ruby'] }
    end
  end

  describe 'addons.coverity_scan.project.name' do
    describe 'given a value' do
      yaml %(
        addons:
          coverity_scan:
            project:
              name: name
      )
      it do
        should serialize_to(
          language: 'ruby',
          os: ['linux'],
          addons: {
            coverity_scan: {
              project: {
                name: 'name'
              }
            }
          }
        )
      end
    end

    describe 'given nil' do
      yaml %(
        addons:
          coverity_scan:
            project:
              name:
      )
      it { should serialize_to defaults }
      it { should have_msg [:error, :'addons.coverity_scan.project', :required, key: 'name', line: 3] }
    end

    describe 'missing key' do
      yaml %(
        addons:
          coverity_scan:
            project: {}
      )
      it { should serialize_to defaults }
      it { should have_msg [:error, :'addons.coverity_scan.project', :required, key: 'name', line: 3] }
    end
  end
end
