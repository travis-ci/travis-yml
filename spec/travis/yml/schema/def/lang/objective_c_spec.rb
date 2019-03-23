describe Travis::Yml::Schema::Def::ObjectiveC, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:"objective-c"] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :'objective-c',
        title: 'Objective-c',
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
        aliases: {
          rvm: [
            :ruby
          ]
        },
        only: {
          rvm: {
            language: [
              'objective-c'
            ]
          },
          gemfile: {
            language: [
              'objective-c'
            ]
          },
          xcode_scheme: {
            language: [
              'objective-c'
            ]
          },
          xcode_sdk: {
            language: [
              'objective-c'
            ]
          },
          podfile: {
            language: [
              'objective-c'
            ]
          },
          bundler_args: {
            language: [
              'objective-c'
            ]
          },
          xcode_project: {
            language: [
              'objective-c'
            ]
          },
          xcode_workspace: {
            language: [
              'objective-c'
            ]
          },
          xctool_args: {
            language: [
              'objective-c'
            ]
          }
        }
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/objective-c'
      )
    end
  end
end
