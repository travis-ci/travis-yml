require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'coverity_scan' do
    describe 'project' do
      it { should validate addons: { coverity_scan: { project: { name: 'str' } } } }
      it { should validate addons: { coverity_scan: { project: { name: 'str', version: 'str' } } } }
      it { should validate addons: { coverity_scan: { project: { name: 'str', description: 'str' } } } }

      it { should_not validate addons: { coverity_scan: { project: 1 } } }
      it { should_not validate addons: { coverity_scan: { project: true } } }
      it { should_not validate addons: { coverity_scan: { project: 'str' } } }
      it { should_not validate addons: { coverity_scan: { project: ['str'] } } }
      it { should_not validate addons: { coverity_scan: { project: { unknown: 'str' } } } }
      it { should_not validate addons: { coverity_scan: { project: [ name: 'str' ] } } }
    end

    describe 'branch_pattern' do
      it { should validate addons: { coverity_scan: { branch_pattern: 'str' } } }

      it { should_not validate addons: { coverity_scan: { branch_pattern: 1 } } }
      it { should_not validate addons: { coverity_scan: { branch_pattern: true } } }
      it { should_not validate addons: { coverity_scan: { branch_pattern: ['str'] } } }
      it { should_not validate addons: { coverity_scan: { branch_pattern: { name: 'str' } } } }
      it { should_not validate addons: { coverity_scan: { branch_pattern: [ name: 'str' ] } } }
    end

    describe 'build_command' do
      it { should validate addons: { coverity_scan: { build_command: 'str' } } }

      it { should_not validate addons: { coverity_scan: { build_command: 1 } } }
      it { should_not validate addons: { coverity_scan: { build_command: true } } }
      it { should_not validate addons: { coverity_scan: { build_command: ['str'] } } }
      it { should_not validate addons: { coverity_scan: { build_command: { name: 'str' } } } }
      it { should_not validate addons: { coverity_scan: { build_command: [ name: 'str' ] } } }
    end

    describe 'build_command_prepend' do
      it { should validate addons: { coverity_scan: { build_command_prepend: 'str' } } }

      it { should_not validate addons: { coverity_scan: { build_command_prepend: 1 } } }
      it { should_not validate addons: { coverity_scan: { build_command_prepend: true } } }
      it { should_not validate addons: { coverity_scan: { build_command_prepend: ['str'] } } }
      it { should_not validate addons: { coverity_scan: { build_command_prepend: { name: 'str' } } } }
      it { should_not validate addons: { coverity_scan: { build_command_prepend: [ name: 'str' ] } } }
    end

    describe 'build_script_url' do
      it { should validate addons: { coverity_scan: { build_script_url: 'str' } } }

      it { should_not validate addons: { coverity_scan: { build_script_url: 1 } } }
      it { should_not validate addons: { coverity_scan: { build_script_url: true } } }
      it { should_not validate addons: { coverity_scan: { build_script_url: ['str'] } } }
      it { should_not validate addons: { coverity_scan: { build_script_url: { name: 'str' } } } }
      it { should_not validate addons: { coverity_scan: { build_script_url: [ name: 'str' ] } } }
    end

    describe 'notification_email' do
      it { should validate addons: { coverity_scan: { notification_email: 'str' } } }

      it { should_not validate addons: { coverity_scan: { notification_email: 1 } } }
      it { should_not validate addons: { coverity_scan: { notification_email: true } } }
      it { should_not validate addons: { coverity_scan: { notification_email: ['str'] } } }
      it { should_not validate addons: { coverity_scan: { notification_email: { name: 'str' } } } }
      it { should_not validate addons: { coverity_scan: { notification_email: [ name: 'str' ] } } }
    end
  end
end
