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
                :'objective-c'
              ]
            }
        },
        {
          value: 'osx',
          except: {
            language: [
              :php,
              :perl,
              :erlang,
              :groovy,
              :clojure,
              :scala,
              :haskell
            ]
          }
        },
        {
          value: 'windows',
          only: {
            language: [
              :bash,
              :csharp,
              :powershell,
              :script,
              :sh,
              :shell
            ]
          }
        }
      ],
      types: [
        {
          name: :os,
          type: :fixed,
          downcase: true,
          defaults: [
            {
              value: 'linux',
              except: {
                language: [
                  :'objective-c'
                ]
              }
            },
            {
              value: 'osx',
              except: {
                language: [
                  :php,
                  :perl,
                  :erlang,
                  :groovy,
                  :clojure,
                  :scala,
                  :haskell
                ]
              }
            },
            {
              value: 'windows',
              only: {
                language: [
                  :bash,
                  :csharp,
                  :powershell,
                  :script,
                  :sh,
                  :shell
                ]
              }
            }
          ],
          values: [
            {
              value: 'linux',
              alias: [
                'ubuntu'
              ],
              except: {
                language: [
                  :'objective-c'
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
                  :php,
                  :perl,
                  :erlang,
                  :groovy,
                  :clojure,
                  :scala,
                  :haskell
                ]
              }
            },
            {
              value: 'windows',
              alias: [
                'win'
              ],
              only: {
                language: [
                  :bash,
                  :csharp,
                  :powershell,
                  :script,
                  :sh,
                  :shell
                ]
              }
            }
          ]
        }
      ]
    )
  end
end

