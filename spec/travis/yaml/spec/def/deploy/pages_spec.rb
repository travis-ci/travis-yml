describe Travis::Yaml::Spec::Def::Deploy::Pages do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :pages,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      }
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :edge)).to eq(
      github_token: {
        key: :github_token,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              "github-token"
            ]
          }
        ]
      },
      repo: {
        key: :repo,
        types: [
          {
            type: :scalar
          }
        ]
      },
      target_branch: {
        key: :target_branch,
        types: [
          {
            type: :scalar,
            alias: [
              "target-branch"
            ]
          }
        ]
      },
      local_dir: {
        key: :local_dir,
        types: [
          {
            type: :scalar,
            alias: [
              "local-dir"
            ]
          }
        ]
      },
      fqdn: {
        key: :fqdn,
        types: [
          {
            type: :scalar
          }
        ]
      },
      project_name: {
        key: :project_name,
        types: [
          {
            type: :scalar,
            alias: [
              "project-name"
            ]
          }
        ]
      },
      email: {
        key: :email,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      name: {
        key: :name,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
