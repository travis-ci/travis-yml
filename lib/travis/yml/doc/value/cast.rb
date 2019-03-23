# frozen_string_literal: true
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Value
        class Cast < Obj.new(:value, :type)
          TRUES   = ['true', 'on', 'yes', 'enabled', 'required']
          FALSES  = ['false', 'off', 'no', 'disabled', 'not required']
          BOOLS   = TRUES + FALSES

          TRUE    = /(#{TRUES.join('|')})/
          FALSE   = /(#{FALSES.join('|')})/

          def apply
            send(:"to_#{type}", value)
          end

          def msgs
            @msgs ||= []
          end

          private

            def to_str(value)
              case value
              when Symbol     then value.to_s
              when Numeric    then value.to_s
              when TrueClass  then value.to_s
              when FalseClass then value.to_s
              else value
              end
            end

            def to_enum(value)
              to_str(value)
            end

            def to_num(value)
              return value unless str?(value) && num?(value)
              value.include?('.') ? value.to_f : value.to_i
            end

            def to_bool(value)
              case value
              when Numeric then value
              when FALSE   then false
              when TRUE    then true
              when String  then match(value)
              else !!value
              end
            end

            def match(value)
              value = value.gsub(/\W/, '')
              matched = Match.new(BOOLS, value).run
              return self.value if matched.nil?
              msgs << [:find_value, original: value, value: matched]
              to_bool(matched)
            end
        end
      end
    end
  end
end
