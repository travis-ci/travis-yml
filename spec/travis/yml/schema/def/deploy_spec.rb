describe Travis::Yml::Schema::Def::Deploy::Deploy, 'structure' do
  describe 'definitions' do
    # describe 'deploys' do
    #   subject { Travis::Yml::Schema::Def::Deploy::Deploys.new(nil, {}).definitions[:type][:deploys] }
    #   it { puts JSON.pretty_generate(subject)[0..400] }
    # end

    describe 'conditions' do
      subject { Travis::Yml.schema[:definitions][:deploy][:conditions] }

      xit { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :deploy_conditions,
          title: 'Deploy Conditions',
          normal: true,
          anyOf: [
            {
              type: :object,
              normal: true,
              properties: {
                branch: {
                  '$ref': '#/definitions/deploy/branches'
                },
                repo: {
                  type: :string
                },
                condition: {
                  '$ref': '#/definitions/type/strs'
                },
                all_branches: {
                  type: :boolean
                },
                tags: {
                  type: :boolean
                },
                jdk: {
                  type: :string
                },
                crystal: {
                  type: :string
                },
                dotnet: {
                  type: :string
                },
                mono: {
                  type: :string
                },
                solution: {
                  type: :string
                },
                d: {
                  type: :string
                },
                dart: {
                  type: :string
                },
                dart_task: {
                  type: :string
                },
                elixir: {
                  type: :string
                },
                otp_release: {
                  type: :string
                },
                elm: {
                  type: :string
                },
                node_js: {
                  type: :string
                },
                go: {
                  type: :string
                },
                ghc: {
                  type: :string
                },
                haxe: {
                  type: :string
                },
                julia: {
                  type: :string
                },
                nix: {
                  type: :string
                },
                rvm: {
                  type: :string
                },
                gemfile: {
                  type: :string
                },
                xcode_scheme: {
                  type: :string
                },
                xcode_sdk: {
                  type: :string
                },
                perl: {
                  type: :string
                },
                perl6: {
                  type: :string
                },
                php: {
                  type: :string
                },
                python: {
                  type: :string
                },
                r: {
                  type: :string
                },
                rust: {
                  type: :string
                },
                scala: {
                  type: :string
                },
                smalltalk: {
                  type: :string
                },
                smalltalk_config: {
                  type: :string
                },
                smalltalk_vm: {
                  type: :string
                },
                arch: {
                  type: :string
                },
                compiler: {
                  type: :string
                },
                os: {
                  type: :string
                }
              },
              additionalProperties: false,
              prefix: :branch,
              keys: {
                branch: {
                  aliases: [
                    :branches
                  ]
                },
                node_js: {
                  aliases: [
                    :node
                  ]
                },
                rvm: {
                  aliases: [
                    :ruby
                  ]
                },
                gemfile: {
                  aliases: [
                    :gemfiles
                  ]
                }
              }
            },
            {
              '$ref': '#/definitions/deploy/branches'
            }
          ]
        )
      end
    end
  end
end
