# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Imports < Type::Seq
          register :imports

          def define
            title 'Imports'

            summary 'Build configuration imports'
            see 'Build Config Imports': 'https://docs.travis-ci.com/user/build-config-imports/'

            description <<~str
              Import YAML config snippets that can be shared across repositories.
            str

            normal
            type :import
            export
          end
        end

        class Import < Type::Map
          register :import

          SOURCE = %r((.*/.*:)?.+\.(yml|json)(@.*)?)

          def define
            normal
            prefix :source

            map :source, to: :import_template, summary: 'The source to import build config from', eg: './import.yml@v1'
            map :mode,   to: :str, values: ['merge', 'deep_merge', 'deep_merge_append', 'deep_merge_prepend'], summary: 'How to merge the imported config into the target config (defaults to deep_merge_append)'
            map :if,     to: :condition

            export
          end
        end

        class ImportTemplate < Type::Str
          registry :import
          register :import_template

          def define
            vars *%w(
              commit_message
            )

            export
          end
        end
      end
    end
  end
end
