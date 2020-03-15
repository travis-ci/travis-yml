# frozen_string_literal: true
require 'travis/yml/doc/schema/node'

module Travis
  module Yml
    module Doc
      module Schema
        class Any < Node
          include Enumerable

          def self.opts
            @opts ||= super + %i(detect)
          end

          attr_writer :schemas

          def opts=(opts)
            @opts = opts
            # TODO defaults have to be pushed down to child schemas in case
            # they were defined on the mapping (and thus, the ref). does this
            # apply to other options, too? also see Seq#opts=
            @schemas = schemas.map(&:dup)
            schemas.each { |schema| schema.opts = merge(only(opts, :defaults, :strict), schema.opts) }
          end

          def matches?(value)
            any? { |schema| schema.matches?(value) }
          end

          def schemas
            @schemas ||= []
          end

          def [](ix)
            schemas[ix]
          end

          def first
            schemas.first
          end

          def each(&block)
            schemas.each(&block)
          end

          def type
            :any
          end

          def default?
            # p schemas.map(&:opts).map(&:keys) if opts[:defaults]
            opts[:defaults] || any?(&:default?)
          end

          def detect?
            !!opts[:detect]
          end

          def all_keys
            map(&:all_keys)
          end

          def aliases
            [super, map(&:aliases)].flatten
          end
          memoize :aliases

          def supports
            merge(super, *map(&:supports))
          end
          memoize :supports

          def dup
            @schemas = schemas.map(&:dup)
            super
          end

          def to_h
            compact(id: id, key: key, type: type, schemas: schemas&.map(&:to_h), opts: opts)
          end
        end
      end
    end
  end
end
