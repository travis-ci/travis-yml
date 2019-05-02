describe Travis::Yml, 'addons' do
  subject { described_class.apply(parse(yaml)) }

  describe 'drops an unknown addon' do
    yaml %(
      addons:
        unknown:
          foo: bar
    )
    it { should serialize_to addons: { unknown: { foo: 'bar' } } }
    it { should have_msg [:warn, :addons, :unknown_key, key: 'unknown', value: { foo: 'bar' }] }
  end

  describe 'given a nested, misplaced hash (1)', v2: true, migrate: true do
    yaml %(
      addons:
        sauce_connect:
          sauce_connect:
            enabled: true
    )
    it { should serialize_to addons: { sauce_connect: { enabled: true } } }
    it { should have_msg [:warn, :'addons.sauce_connect', :migrate, key: 'sauce_connect', to: 'addons', value: true] }
  end

  describe 'given a nested, misplaced hash (2)', v2: true, migrate: true do
    yaml %(
      addons:
        sauce_connect: true
        addons:
          hosts: localhost
    )
    it { should serialize_to addons: { sauce_connect: { enabled: true, hosts: 'localhost' } } }
    it { should have_msg [:warn, :addons, :migrate, key: 'addons', to: 'root', value: { hosts: 'localhost' }] }
  end

  describe 'given an array with a hash with a misplaced key with a nested, misplaced key', v2: true, migrate: true do
    yaml %(
      addons:
        coverity_scan:
        project:
          name: name
          build_command: cmd
    )
    it { should have_msg [:warn, :addons, :unexpected_seq, value: value[:addons][0]] }
    it { should have_msg [:warn, :addons, :migrate, key: 'project', to: 'coverity_scan', value: { name: 'name', build_command: 'cmd' }] }
    it { should have_msg [:warn, :'addons.coverity_scan.project', :migrate, key: 'build_command', to: 'coverity_scan', value: 'cmd'] }
  end
end
