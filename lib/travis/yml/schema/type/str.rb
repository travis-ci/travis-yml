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
            registry_key
          end
        end

        class Strs < Seq
          register :strs

          def self.type
            registry_key
          end

          def namespace
            :type
          end

          def id
            registry_key
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

