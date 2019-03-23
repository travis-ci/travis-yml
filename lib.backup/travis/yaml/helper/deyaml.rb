# frozen_string_literal: true
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Helper
      module Deyaml
        def deyaml(obj)
          case obj
          when Hash
            obj = drop_keys(obj)
            obj = obj.map { |key, obj| [deyaml_key(key), deyaml(obj)] }.to_h
          when Array
            obj.map { |obj| deyaml(obj) }
          else
            obj
          end
        end

        DROP = /^(configured|result|fetching_failed|parsing_failed)$/

        def drop_keys(obj)
          # this should only happen during validation: our request configs
          # already have these keys stored. we might remove this once we're
          # done validating, and made sure these are not added anymore
          obj.keys.each do |key|
            obj.delete(key) if key.to_s.gsub(/\W/, '') =~ DROP
          end
          obj
        end

        def deyaml_key(key)
          # this should only happen during validation: our request configs
          # already have these values stored. once we're done validating
          # we might remove this
          key.is_a?(TrueClass) ? :on : key.to_s.sub(/^:/, '').to_sym
        end
      end
    end
  end
end
