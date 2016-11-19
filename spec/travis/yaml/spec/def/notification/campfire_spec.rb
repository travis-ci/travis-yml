describe Travis::Yaml::Spec::Def::Notification::Campfire do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:campfire] }

  it do
    expect(spec).to eq(
      key: :campfire,
      types: [
        {
          name: :campfire,
          type: :map,
          prefix: {
            key: :rooms,
            type: [:str, :secure, :seq]
          },
          change: [
            {
              name: :inherit,
              keys: [
                :disabled,
                :on_start,
                :on_success,
                :on_failure
              ]
            },
            {
              name: :enable
            }
          ],
          map: {
            enabled: {
              key: :enabled,
              types: [
                {
                  type: :scalar,
                  cast: :bool,
                }
              ]
            },
            disabled: {
              key: :disabled,
              types: [
                {
                  type: :scalar,
                  cast: :bool,
                }
              ]
            },
            rooms: {
              key: :rooms,
              types: [
                {
                  type: :seq,
                  secure: true,
                  types: [
                    {
                      type: :scalar
                    }
                  ]
                }
              ]
            },
            template: {
              key: :template,
              types: [
                {
                  name: :templates,
                  type: :seq,
                  types: [
                    {
                      name: :template,
                      type: :scalar,
                      validate: [
                        {
                          name: :template,
                          vars: [
                            'repository',
                            'repository_slug',
                            'repository_name',
                            'build_number',
                            'build_id',
                            'build_url',
                            'branch',
                            'commit',
                            'commit_subject',
                            'commit_message',
                            'author',
                            'pull_request',
                            'pull_request_number',
                            'pull_request_url',
                            'compare_url',
                            'result',
                            'duration',
                            'elapsed_time',
                            'message',
                          ],
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            on_start: {
              key: :on_start,
              types: [
                {
                  name: :callback,
                  type: :fixed,
                  values: [
                    {
                      value: 'always',
                      alias: ['true']
                    },
                    {
                      value: 'never',
                      alias: ['false']
                    },
                    {
                      value: 'change',
                      alias: ['changed']
                    }
                  ]
                }
              ]
            },
            on_success: {
              key: :on_success,
              types: [
                {
                  name: :callback,
                  type: :fixed,
                  values: [
                    {
                      value: 'always',
                      alias: ['true']
                    },
                    {
                      value: 'never',
                      alias: ['false']
                    },
                    {
                      value: 'change',
                      alias: ['changed']
                    }
                  ]
                }
              ]
            },
            on_failure: {
              key: :on_failure,
              types: [
                {
                  name: :callback,
                  type: :fixed,
                  values: [
                    {
                      value: 'always',
                      alias: ['true']
                    },
                    {
                      value: 'never',
                      alias: ['false']
                    },
                    {
                      value: 'change',
                      alias: ['changed']
                    }
                  ]
                }
              ]
            }
          }
        }
      ]
    )
  end
end
