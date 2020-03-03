# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class ObjectiveC < Type::Lang
          register :'objective-c'

          def define
            title 'Objective-C'
            summary 'Objective-C language support'
            see 'Building an Objective-C Project': 'https://docs.travis-ci.com/user/languages/objective-c/'
            aliases :objective_c, :swift

            matrix :rvm,            alias: [:ruby, :rbenv]
            matrix :gemfile
            matrix :xcode_scheme
            matrix :xcode_sdk

            map :podfile,           to: :str
            map :bundler_args,      to: :str
            map :xcode_destination, to: :str
            map :xcode_project,     to: :str
            map :xcode_workspace,   to: :str
            map :xctool_args,       to: :str
          end
        end
      end
    end
  end
end
