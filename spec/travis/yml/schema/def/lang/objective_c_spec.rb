describe Travis::Yml::Schema::Def::ObjectiveC do
  subject { Travis::Yml.schema[:definitions][:language][:"objective-c"] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :'objective-c',
      title: 'Objective-C',
      summary: instance_of(String),
      see: instance_of(Hash),
      type: :object,
      properties: {
        rvm: {
          '$ref': '#/definitions/type/strs',
          aliases: [
            :ruby,
            :rbenv
          ],
          flags: [
            :expand
          ],
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        gemfile: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        xcode_scheme: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        xcode_sdk: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        podfile: {
          type: :string,
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        bundler_args: {
          type: :string,
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        xcode_destination: {
          type: :string,
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        xcode_project: {
          type: :string,
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        xcode_workspace: {
          type: :string,
          only: {
            language: [
              'objective-c'
            ]
          }
        },
        xctool_args: {
          type: :string,
          only: {
            language: [
              'objective-c'
            ]
          }
        }
      },
      normal: true
    )
  end
end
