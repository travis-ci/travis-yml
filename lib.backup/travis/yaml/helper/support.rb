# frozen_string_literal: true
require 'travis/support/obj'

module Travis
  module Yaml
    class Support < Obj.new(:spec, :opts)
      include Yaml::Helper::Common

      def map
        @map ||= spec.map do |key, spec|
          [key, expand_key?(spec) && !expand? ? unexpand(spec) : spec]
        end.to_h
      end

      private

        # The support include needs to unexpand (pop the first type out
        # of sequences) if the given node does not expand the matrix. This
        # is true for all nodes except the root node. E.g. `ruby` accepts a
        # sequence of scalars on `root`, but a scalar on `matrix.include`.
        def unexpand(spec)
          return spec unless seq?(spec)
          spec = dup(spec)
          seq  = spec[:types].first
          type = seq.merge(seq[:types].first)
          spec.merge(types: [type])
        end

        def expand?
          !!opts[:expand]
        end

        def expand_key?(spec)
          spec[:types].first[:expand]
        end

        def seq?(spec)
          spec[:types].first[:type] == :seq
        end

        def dup(obj)
          case obj
          when Hash
            obj.map { |key, obj| [key, dup(obj)] }.to_h
          when Array
            obj.map { |obj| dup(obj) }
          when Symbol, TrueClass, FalseClass, NilClass, Numeric
            obj
          else
            obj.respond_to?(:dup) ? obj.dup : obj
          end
        end
    end
  end
end
