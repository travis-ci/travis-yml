describe Travis::Yml, 'addon: coverity_scan' do
  subject { described_class.apply(parse(yaml)) }

  describe 'build_script_url' do
    yaml %(
      addons:
        coverity_scan:
          build_script_url: url
    )
    it { should serialize_to addons: { coverity_scan: { build_script_url: 'url' } } }
    it { should_not have_msg }
  end

  describe 'branch_pattern' do
    yaml %(
      addons:
        coverity_scan:
          branch_pattern: pattern
    )
    it { should serialize_to addons: { coverity_scan: { branch_pattern: 'pattern' } } }
    it { should_not have_msg }
  end

  describe 'notification_email' do
    yaml %(
      addons:
        coverity_scan:
          notification_email: email
    )
    it { should serialize_to addons: { coverity_scan: { notification_email: 'email' } } }
    it { should_not have_msg }
  end

  describe 'build_command' do
    yaml %(
      addons:
        coverity_scan:
          build_command: cmd
    )
    it { should serialize_to addons: { coverity_scan: { build_command: 'cmd' } } }
    it { should_not have_msg }
  end

  describe 'build_command_prepend' do
    yaml %(
      addons:
        coverity_scan:
          build_command_prepend: str
    )
    it { should serialize_to addons: { coverity_scan: { build_command_prepend: 'str' } } }
    it { should_not have_msg }
  end

  describe 'project' do
    describe 'given a str' do
      yaml %(
        addons:
          coverity_scan:
            project: project
      )
      it { should serialize_to addons: { coverity_scan: { project: { name: 'project' } } } }
      it { should_not have_msg }
    end

    describe 'given a map' do
      yaml %(
        addons:
          coverity_scan:
            project:
              name: project
              version: version
              description: description
      )
      it { should serialize_to addons: { coverity_scan: { project: { name: 'project', version: 'version', description: 'description' } } } }
      it { should_not have_msg }
    end
  end
end
