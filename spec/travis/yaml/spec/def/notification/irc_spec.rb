describe Travis::Yaml::Spec::Def::Notification::Irc do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:irc] }

  it do
    expect(spec).to eq(
      key: :irc,
      types: [
        {
          name: :irc,
          type: :map,
          prefix: {
            key: :channels
          },
          normalize: [
            name: :inherit,
            keys: [
              :on_success,
              :on_failure
            ]
          ],
          map: {
            channels: {
              key: :channels,
              types: [
                {
                  type: :seq,
                  cast: [
                    :secure
                  ],
                  types: [
                    {
                      type: :scalar
                    }
                  ]
                }
              ]
            },
            channel_key: {
              key: :channel_key,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            password: {
              key: :password,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            nickserv_password: {
              key: :nickserv_password,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            nick: {
              key: :nick,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            use_notice: {
              key: :use_notice,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :bool
                  ]
                }
              ]
            },
            skip_join: {
              key: :skip_join,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :bool
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
                      conform: [
                        {
                          name: :template,
                          vars: [
                            'repository',
                            'repository_slug',
                            'repository_name',
                            'build_number',
                            'build_id',
                            'pull_request',
                            'pull_request_number',
                            'branch',
                            'commit',
                            'author',
                            'commit_subject',
                            'commit_message',
                            'result',
                            'duration',
                            'message',
                            'compare_url',
                            'build_url',
                            'pull_request_url'
                          ],
                          stage: :validate
                        }
                      ]
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
                      value: 'always'
                    },
                    {
                      value: 'never'
                    },
                    {
                      value: 'change'
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
                      value: 'always'
                    },
                    {
                      value: 'never'
                    },
                    {
                      value: 'change'
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
