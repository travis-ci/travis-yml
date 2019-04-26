# frozen_string_literal: true
require 'travis/env_vars'
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class EnvVars < Base
          def apply
            # puts
            # p env_vars?
            # p value.serialize
            apply? && env_vars? ? env_vars : value
          end

          private

            def apply?
              schema.change?(:env_vars)
            end

            def env_vars?
              value.seq? && value.all? do |value|
                value.map? || value.secure? || value.str?
              end
            end

            def env_vars
              vars = value.value.map do |value|
                value = parse(value) if value.str? && value.value.include?('=')
                value = split(value) if value.map?
                value
              end
              build(vars.flatten(1))
            end

            def split(value)
              value.map { |key, value| { key => value } }
            end

            def parse(value)
              vars = Travis::EnvVars::String.new(value.value).parse
              vars = symbolize(vars)
              build(vars)
            rescue Travis::EnvVars::ParseError => e
              value
            end
        end
      end
    end
  end
end
