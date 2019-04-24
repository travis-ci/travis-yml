# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Dart < Lang
          register :dart

          def define
            matrix :dart
            matrix :dart_task, to: Tasks

            map :with_content_shell, to: :bool
          end

          class Tasks < Dsl::Any
            def define
              add :seq, type: [Task, :str]
            end
          end

          class Task < Dsl::Map
            def define
              map :test, to: :str
              map :dartanalyzer, to: :str
              map :dartfmt, to: :bool
              map :install_dartium, to: :bool
              map :xvfb, to: :bool
            end
          end
        end
      end
    end
  end
end
