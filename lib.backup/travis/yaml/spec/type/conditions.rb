# frozen_string_literal: true
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Spec
      module Type
        class Conditions
          include Helper::Common

          attr_reader :opts

          KEYS = [:only, :except]

          def initialize(opts)
            @opts = only(opts, *KEYS).map { |key, opts| [key, normalize(opts)] }.to_h
          end

          def to_h
            opts
          end

          def merge(other)
            [:only, :except].each do |type|
              opts[type] = merge_type(opts[type] || {}, other[type] || {})
            end
            self
          end

          private

            def merge_type(one, other)
              keys = one.keys + other.keys
              keys.map { |key| [key, merge_values(key, one, other)] }.to_h
            end

            def merge_values(key, one, other)
              one.fetch(key, []).concat(other.fetch(key, [])).uniq
            end

            def normalize(opts)
              opts.map { |key, value| [key, to_a(value).map(&:to_s)] }.to_h
            end

            def to_a(obj)
              obj.is_a?(Array) ? obj : [obj].compact
            end
        end
      end
    end
  end
end
