describe Travis::Yaml::Spec::Def::Oss do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :oss,
      type: :seq,
      defaults: [
        {
          value: 'linux',
            except: {
              language: [
                :objective_c
              ]
            }
        },
        {
            value: 'osx',
            except: {
              language: [
                :node_js,
                :python,
                :php,
                :perl,
                :erlang,
                :groovy,
                :clojure,
                :scala,
                :haskell
              ]
            }
          }
      ],
      types: [
        {
          name: :os,
          type: :fixed,
          downcase: true,
          values: [
            {
              value: 'linux',
              alias: [
                'ubuntu'
              ],
              except: {
                language: [
                  :objective_c
                ]
              }
            },
            {
              value: 'osx',
              alias: [
                'mac',
                'macos',
                'ios'
              ],
              except: {
                language: [
                  :node_js,
                  :python,
                  :php,
                  :perl,
                  :erlang,
                  :groovy,
                  :clojure,
                  :scala,
                  :haskell
                ]
              }
            }
          ]
        }
      ]
    )
  end
end

