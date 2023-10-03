# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Workspaces < Type::Seq
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
            type :workspace
            export
          end
        end

        class Workspace < Type::Map
          register :workspace

          def define
            prefix :name

            map :name, to: :str
            map :create, to: :bool

            normal
            export
          end
        end
      end
    end
  end
end

