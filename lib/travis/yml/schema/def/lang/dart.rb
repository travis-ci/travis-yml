# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Dart < Type::Lang
          register :dart

          def define
            title 'Dart'
            summary 'Dart language support'
            see 'Building a Dart Project': 'https://docs.travis-ci.com/user/languages/dart/'
            matrix :dart
            matrix :dart_task, to: :dart_tasks

            map :with_content_shell, to: :bool
          end

          class Tasks < Type::Seq
            register :dart_tasks

            def define
              type :any, types: [:dart_task, :str]
            end
          end

          class Task < Type::Map
            register :dart_task

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
