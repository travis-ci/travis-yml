# frozen_string_literal: true
require 'sh_vars'
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class EnvVars < Base
          def apply
            other = apply? ? env_vars : value
            # p other.serialize
            other
          end

          private

            def apply?
              schema.change?(:env_vars)
            end

            def env_vars
              vars = value.seq? ? value.value : [value]
              vars = vars.map do |value|
                vars = value.value
                vars = parse(value, vars) if value.str?
                vars = split(vars) if value.map?
                vars || [{}]
              end
              build(vars.flatten(1))
            end

            def split(vars)
              vars.empty? ? [{}] : vars.map { |key, obj| { key => obj } }
            end

            def parse(value, vars)
              vars = vars.empty? ? [[]] : ShVars.parse(vars)
              vars.map { |pair| pair.empty? ? {} : [pair].to_h }
            rescue ShVars::ParseError => e
              value.error :invalid_env_var, var: vars
              [{}]
            end
        end
      end
    end
  end
end
