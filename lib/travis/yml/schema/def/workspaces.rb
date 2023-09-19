# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Workspaces < Type::Map
          register :workspaces

          def define
            title 'Workspaces'

            summary 'Shared build workspaces'

            description <<~str
              Workspaces allow jobs within the same build to share files. They are
              useful when you want to use build artifacts from a previous job.
              For example, you create a cache that can be used in multiple jobs
              in the same build later.
            str

            see 'Workspaces': 'https://docs.travis-ci.com/user/using-workspaces'

            normal

            map :create, to: Class.new(Type::Map) {
              def define
                map :name, to: :str, unique: true
                map :paths, to: :seq
                normal
              end
            }
            map :use, to: Class.new(Type::Map) {
              def define
                map :name, to: :seq, unique: true
              end
            }
            export
          end
        end

        class Workspace < Type::Map
          register :workspace

          def define
            prefix :name

            normal
            export
          end
        end
      end
    end
  end
end

