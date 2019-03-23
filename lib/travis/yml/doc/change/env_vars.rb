# frozen_string_literal: true
require 'travis/env_vars'
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class EnvVar < Base
          def apply
            parse? ? parse : value
          end

          private

            def parse?
              value.str? && value.value.include?('=')
            end

            def parse
              vars = Travis::EnvVars::String.new(value.value).parse
              vars = symbolize(vars)
              build(vars)
            rescue Travis::EnvVars::ParseError => e
              value
            end
        end

        class EnvVars < Base
          def apply
            env_vars? && split? ? split : value
          end

          private

            def env_vars?
              schema.change?(:env_vars)
            end

            def split?
              value.seq? && value.all? { |value| value.map? || value.secure? }
            end

            def split
              vars = value.value.map { |map| map.map { |key, value| { key => value } } }
              build(vars.flatten(1))
            end
        end
      end
    end
  end
end
