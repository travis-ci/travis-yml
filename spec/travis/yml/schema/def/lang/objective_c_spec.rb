describe Travis::Yml::Schema::Def::ObjectiveC, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:"objective-c"] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :'language_objective-c',
        title: 'Language Objective C',
        type: :object,
        properties: {
          rvm: {
            '$ref': '#/definitions/strs'
          },
          gemfile: {
            '$ref': '#/definitions/strs'
          },
          xcode_scheme: {
            '$ref': '#/definitions/strs'
          },
          xcode_sdk: {
            '$ref': '#/definitions/strs'
          },
          podfile: {
            type: :string
          },
          bundler_args: {
            type: :string
          },
          xcode_destination: {
            type: :string
          },
          xcode_project: {
            type: :string
          },
          xcode_workspace: {
            type: :string
          },
          xctool_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
          rvm: {
            aliases: [
              :ruby
            ],
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          gemfile: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          xcode_scheme: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          xcode_sdk: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          podfile: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          bundler_args: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          xcode_destination: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          xcode_project: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          xcode_workspace: {
            only: {
              language: [
                'objective-c'
              ]
            }
          },
          xctool_args: {
            only: {
              language: [
                'objective-c'
              ]
            }
          }
        }
      )
    end
  end
end
