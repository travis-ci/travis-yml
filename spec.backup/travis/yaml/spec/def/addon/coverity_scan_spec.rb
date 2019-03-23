describe Travis::Yaml::Spec::Def::Addons, 'coverity_scan' do
  let(:spec) { described_class.new.spec[:map][:coverity_scan] }

  it do
    expect(spec).to eq(
      key: :coverity_scan,
      types: [
        {
          name: :coverity_scan,
          type: :map,
          map: {
            project: {
              key: :project,
              types: [
                {
                  name: :coverity_scan_project,
                  type: :map,
                  map: {
                    name: {
                      key: :name,
                      types: [
                        {
                          type: :scalar,
                          required: true
                        }
                      ]
                    },
                    version: {
                      key: :version,
                      types: [
                        {
                          type: :scalar
                        }
                      ]
                    },
                    description: {
                      key: :description,
                      types: [
                        {
                          type: :scalar
                        }
                      ]
                    }
                  }
                }
              ]
            },
            build_script_url: {
              key: :build_script_url,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            branch_pattern: {
              key: :branch_pattern,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            notification_email: {
              key: :notification_email,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            build_command: {
              key: :build_command,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            build_command_prepend: {
              key: :build_command_prepend,
              types: [
                {
                  type: :scalar
                }
              ]
            }
          }
        }
      ]
    )
  end
end
