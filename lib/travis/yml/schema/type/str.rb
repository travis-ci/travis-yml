# frozen_string_literal: true
require 'travis/yml/schema/type/opts'
require 'travis/yml/schema/type/scalar'
require 'travis/yml/schema/type/seq'

module Travis
  module Yml
    module Schema
      module Type
        class Str < Scalar
          include Opts

          register :str

          opts %i(downcase format vars)

          def self.type
            :str
          end
        end

        # anyOf: [
        #   {
        #     type: :array,
        #     minItems: 1,
        #     items: {
        #       anyOf: [
        #         { type: :string }
        #       ]
        #     },
        #     normal: true
        #   },
        #   {
        #     type: :string
        #   }
        # ]
        class Strs < Seq
          register :strs

          def self.type
            :strs
          end

          def id
            :strs
          end

          def types
            [Str.new(self)]
          end

          def opts
            { min_size: 1 }
          end

          def export?
            true
          end
        end
      end
    end
  end
end

