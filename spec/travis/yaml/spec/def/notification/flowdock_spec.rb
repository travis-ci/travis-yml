describe Travis::Yaml::Spec::Def::Notification::Flowdock do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:flowdock] }

  it do
    expect(spec).to eq(
      key: :flowdock,
      types: [
        {
          name: :flowdock,
          type: :map,
          prefix: {
            key: :api_token
          },
          normalize: [
            name: :inherit,
            keys: [
              :on_success,
              :on_failure
            ]
          ],
          map: {
            api_token: {
              key: :api_token,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
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
