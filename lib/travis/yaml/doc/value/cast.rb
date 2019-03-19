# frozen_string_literal: true
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Doc
      module Value
        class Cast < Obj.new(:value, :type)
          Error = Class.new(ArgumentError)

          TYPES = {
            TrueClass  => :bool,
            FalseClass => :bool,
            String     => :str,
            Symbol     => :str,
            Regexp     => :str,
          }

          TRUES   = ['true', 'on', 'yes', 'enabled', 'required']
          FALSES  = ['false', 'off', 'no', 'disabled', 'not required']
          BOOLS   = TRUES + FALSES

          TRUE    = /(#{TRUES.join('|')})/
          FALSE   = /(#{FALSES.join('|')})/

          def apply?
            type != given && !value.is_a?(Hash)
          end

          def apply
            send(:"to_#{type}", value)
          end

          def given
            TYPES[value.class]
          end

          private

            def to_str(value)
              value.to_s
            end

            def to_bool(value)
              case value
              when Integer then value != 0
              when Float   then value != 0.0
              when FALSE   then false
              when TRUE    then true
              when String  then !!match(value)
              else !!value
              end
            end

            def match(value)
              value = value.gsub(/\W/, '')
              matched = Match.new(BOOLS, value).run
              matched.nil? ? self.value : to_bool(matched)
            end
        end
      end
    end
  end
end
