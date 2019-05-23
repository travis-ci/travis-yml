# frozen_string_literal: true
require 'sh_vars'
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class EnvVars < Base
          def apply
            apply? ? env_vars : value
          end

          private

            def apply?
              schema.change?(:env_vars)
            end

            def env_vars
              vars = case value.type
              when :map then env_vars_map
              when :seq then env_vars_seq
              when :str then env_vars_str
              else env_vars_scalar
              end
              build(vars)
            end

            def env_vars_map
              [value.value]
            end

            def env_vars_seq
              value.value.map do |value|
                vars = value.value
                vars = parse(value, vars) if value.str?
                vars || [{}]
              end.flatten(1)
            end

            def env_vars_str
              parse(value, value.value)
            end

            def env_vars_scalar
              value.value
            end

            def parse(value, vars)
              vars = vars.empty? ? [[]] : ShVars.parse(vars)
              vars = vars.map { |pair| pair.empty? ? {} : [pair].to_h }
              vars.inject(&:merge)
            rescue ShVars::ParseError => e
              value.error :invalid_env_var, var: vars
              [{}]
            end
        end
      end
    end
  end
end
