describe Travis::Yaml::Spec::Def::Notification::Webhooks do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:webhooks] }

  it do
    expect(spec).to eq(
      key: :webhooks,
      types: [
        {
          name: :webhooks,
          type: :map,
          alias: ['webhook'],
          prefix: {
            key: :urls,
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
            },
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
            urls: {
              key: :urls,
              types: [
                {
                  type: :seq,
                  types: [
                    {
                      type: :scalar
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
