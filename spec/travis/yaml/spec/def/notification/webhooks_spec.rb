describe Travis::Yaml::Spec::Def::Notification::Webhooks do
  let(:spec) { Travis::Yaml.spec[:map][:notifications][:types][0][:map][:webhooks] }

  it do
    expect(spec).to eq(
      key: :webhooks,
      types: [
        {
          name: :webhooks,
          type: :map,
          alias: [
            'webhook'
          ],
          prefix: {
            key: :urls
          },
          normalize: [
            name: :inherit,
            keys: [
              :on_start,
              :on_success,
              :on_failure
            ]
          ],
          map: {
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
