describe Travis::Yaml::Spec::Def::Notification::Email do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:email] }

  it do
    expect(spec).to eq(
      key: :email,
      types: [
        {
          name: :email,
          type: :map,
          normalize: [
            {
              name: :enabled
            }
          ],
          prefix: {
            key: :recipients
          },
          map: {
            enabled: {
              key: :enabled,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :bool
                  ],
                  defaults: [
                    { value: true }
                  ],
                  required: true
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
