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
              vars = value.seq? ? value.value : [value]
              vars = vars.map do |value|
                value = parse(value) if value.str?
                value = split(value) if value.map?
                value = [{}] if value.none?
                value
              end
              build(vars.flatten(1))
            end

            def split(value)
              value.map { |key, value| { key => value } }
            end

            def parse(value)
              str = value.value
              vars = str.empty? ? [[]] : ShVars.parse(str)
              vars = vars.map { |pair| pair.empty? ? {} : symbolize([pair].to_h) }
              build(vars)
            rescue ShVars::ParseError => e
              value.error :invalid_env_var, var: str
              none
            end
        end
      end
    end
  end
end
