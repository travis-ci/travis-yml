# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Matrix < Dsl::Map
          register :matrix

          def define
            summary 'Build matrix definitions'

            normal
            prefix :include

            map :include,        to: :matrix_entries
            map :exclude,        to: :matrix_entries
            map :allow_failures, to: :matrix_entries, alias: :allowed_failures
            map :fast_finish,    to: :bool, alias: :fast_failure

            export
          end

          class Entries < Dsl::Seq
            register :matrix_entries

            def define
              type :matrix_entry
              export
            end
          end

          class Entry < Dsl::Map
            register :matrix_entry

            def define
              strict false
              aliases :jobs

              map :name,     to: :str, unique: true
              map :language
              map :os
              map :arch
              map :dist
              map :sudo
              map :env,      to: :env_vars
              map :stage,    to: :str
              map :compiler

              include :support, :job

              export
            end
          end
        end
      end
    end
  end
end
