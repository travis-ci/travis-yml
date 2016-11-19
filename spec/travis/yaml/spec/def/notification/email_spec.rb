describe Travis::Yaml::Spec::Def::Notification::Email do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:email] }

  it do
    expect(spec).to eq(
      key: :email,
      types: [
        {
          name: :email,
          type: :map,
          alias: ['emails'],
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
          prefix: {
            key: :recipients,
            type: [:str, :secure, :seq]
          },
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
            recipients: {
              key: :recipients,
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
